class GenerateLessonsJob < ApplicationJob

  queue_as :default

  retry_on RubyLLM::ServiceUnavailableError, attempts: 3, wait: 5.minutes

  def perform
    User.where(role: %w[father mother child]).find_each do |user|
      next if user.lessons.exists?(created_at: (4.hours - 5.minutes).ago..)
      entry_ids_with_embeddings = user.entries.where.not(embedding: nil).ids
      next if entry_ids_with_embeddings.empty?
      lesson = user.lessons.new(body: AI.ask(lesson_prompt(user, entry_ids_with_embeddings)))
      lesson.title = AI.ask(title_prompt(lesson.body)).to_s.first(255)
      lesson.save!
    end
  end

  private

  def lesson_prompt(user, entry_ids_with_embeddings)
    prompt = <<~PROMPT
      Review the following entries and select a mentioned topic, idea or question and generate a short (less than 300
      words) lesson with practical knowledge or fascinating information. Format in html, no markdown.
      Entries: #{context_entries(entry_ids_with_embeddings.sample(5))}
      ---
    PROMPT
    topics = recent_topics(user)
    prompt << "CRITICAL: Do NOT cover the same concept or theme as these recent topics: #{topics}." if topics.present?
    prompt
  end

  def title_prompt(lesson_body)
    "Generate a short title (just a few words, no markdown) for the following:\n#{lesson_body}"
  end

  def recent_topics(user)
    user.lessons.order(created_at: :desc).limit(100).pluck(:title).join(', ')
  end

  def context_entries(entry_ids_with_embeddings)
    Entry.where(id: entry_ids_with_embeddings).map { |e| "#{e.at}\n#{e.body}" }.join("\n---\n")
  end

end
