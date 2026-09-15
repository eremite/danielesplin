class GenerateLessonsJob < ApplicationJob

  queue_as :default

  def perform
    User.where(role: %w[father mother child]).find_each do |user|
      next if user.lessons.exists?(created_at: (4.hours - 5.minutes).ago..)
      entry_ids_with_embeddings = user.entries.where.not(embedding: nil).ids
      next if entry_ids_with_embeddings.present?
      lesson = user.lessons.new(body: chat_model.ask(lesson_prompt(user, entry_ids_with_embeddings)).content)
      lesson.title = chat_model.ask(title_prompt(lesson.body)).content
      lesson.tone = chat_model.ask(tone_prompt(lesson.body)).content
      lesson.save!
    end
  rescue RubyLLM::Error => e
    Rails.logger.error("GenerateLessonsJob: #{e.message}")
  end

  private

  def chat_model
    RubyLLM.chat(model: 'gemini-3.6-flash')
  end

  def lesson_prompt(user, entry_ids_with_embeddings)
    <<~PROMPT
      Select a specific topic or idea from the following entries and generate a short lesson (roughly 100 to 500 words) with useful practical knowledge.
      Entries: #{context_entries(entry_ids_with_embeddings.sample(5))}
      ---
      Avoid these recent topics: #{recent_topics(user)}.
      The user likes: #{tone_of_liked_lessons(user)}.
    PROMPT
  end

  def title_prompt(lesson_body)
    chat_model.ask(<<~PROMPT).content.first(255)
      Generate a brief (less than 255 characters) summary title for the following:
      #{lesson_body}
    PROMPT
  end

  def tone_prompt(lesson_body)
    chat_model.ask(<<~PROMPT).content.first(255)
      Generate a brief (less than 255 characters) description of the tone, format and presentation of this content to
      create more like it in the future.
      #{lesson_body}
    PROMPT
  end

  def recent_topics(user)
    user.lessons.order(created_at: :desc).limit(6).pluck(:title).join(', ')
  end

  def context_entries(entry_ids_with_embeddings)
    Entry.where(id: entry_ids_with_embeddings).map { |e| "#{e.at}\n#{e.body}" }.join("\n---\n")
  end

  def tone_of_liked_lessons(user)
    user.lessons.where.not(liked_at: nil).order(created_at: :desc).limit(3).pluck(:tone).join(', ')
  end

end
