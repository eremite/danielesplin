class GenerateLessonsJob < ApplicationJob

  queue_as :default

  def perform
    User.where(role: %w[father mother child]).find_each do |user|
      next if user.lessons.exists?(created_at: (4.hours - 5.minutes).ago..)
      entry_ids_with_embeddings = user.entries.where.not(embedding: nil).ids
      next if entry_ids_with_embeddings.empty?
      lesson = user.lessons.new(body: chat_model.ask(lesson_prompt(user, entry_ids_with_embeddings)).content)
      lesson.title = chat_model.ask(title_prompt(lesson.body)).content.to_s.first(255)
      lesson.tone = chat_model.ask(tone_prompt(lesson.body)).content.to_s.first(255)
      lesson.save!
    end
  end

  private

  def chat_model
    RubyLLM.chat(model: 'gemini-3.6-flash')
  end

  def lesson_prompt(user, entry_ids_with_embeddings)
    prompt = <<~PROMPT
      Select a specific topic, idea or question from the following entries and generate a short (less than 400 words)
      lesson with useful practical knowledge. Be succinct! Format in html.
      Entries: #{context_entries(entry_ids_with_embeddings.sample(5))}
      ---
    PROMPT
    topics = recent_topics(user)
    prompt << "Avoid these recent topics: #{topics}." if topics.present?
    tone = tone_of_liked_lessons(user)
    prompt << "The user likes: #{tone}." if tone.present?
    prompt
  end

  def title_prompt(lesson_body)
    "Generate a short title (just a few words, no markdown) for the following:\n#{lesson_body}"
  end

  def tone_prompt(lesson_body)
    <<~PROMPT
      Generate a single short succinct sentence (no markdown) of one or two elmeents of the tone, format and/or
      presentation of this content to create more like it in the future.
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
