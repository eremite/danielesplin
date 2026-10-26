class GenerateLessonsJob < ApplicationJob

  queue_as :default

  retry_on RubyLLM::ServiceUnavailableError, attempts: 3, wait: 5.minutes

  def perform
    if question_lesson.present?
      create_questionable_lesson
    elsif liked_lesson.present?
      create_likeable_lesson
    else
      create_random_lesson
    end
  end

  private

  def question_lesson
    @question_lesson ||= user.lessons.questionable.order(created_at: :asc).first
  end

  def user
    @user ||= User.find_by(role: 'father')
  end

  def create_questionable_lesson
    lesson = user.lessons.new(body: AI.ask(questionable_lesson_prompt))
    lesson.title = AI.ask(title_prompt(lesson.body)).to_s.first(255)
    lesson.save!
    lesson
  end

  def questionable_lesson_prompt
    <<~PROMPT
      Generate a short lesson (less than 400 words) with accurate practical knowledge related to the following topic.
      No title, no introduction, no commentary. Include expert details. Format in html, not markdown.
      If there is a question, wrap the answer in bold tags.
      Requested Topic: #{question_lesson.question}
    PROMPT
  end

  def liked_lesson
    @liked_lesson ||= user.lessons.liked.order(created_at: :asc).first
  end

  def create_likeable_lesson
    lesson = user.lessons.new(body: AI.ask(likable_lesson_prompt))
    lesson.title = AI.ask(title_prompt(lesson.body)).to_s.first(255)
    liked_lesson.update!(liked_at: nil) if lesson.save!
    lesson
  end

  def likable_lesson_prompt
    <<~PROMPT
      Generate a short lesson (less than 400 words) with accurate practical knowledge or accurate fascinating
      information with further details or on a similar related subject as the following lesson.
      No title, no introduction, no commentary. Include expert details. Format in html, not markdown.
      Liked Lesson: #{liked_lesson.body}
    PROMPT
  end

  def create_random_lesson
    lesson = user.lessons.new(body: AI.ask(random_lesson_prompt))
    lesson.title = AI.ask(title_prompt(lesson.body)).to_s.first(255)
    lesson.save!
    lesson
  end

  def random_lesson_prompt
    prompt = <<~PROMPT
      Generate a short (less than 400 words) lesson with practical knowledge, fascinating information or important
      context on a random topic. Emphasize accuracy. No title, no introduction, no commentary. Include expert details.
      Pick something not related to these recent topics: #{recent_topics}.
      Format in html, no markdown.
    PROMPT
  end

  def title_prompt(lesson_body)
    "Generate a short title (just a few words, no markdown) for the following:\n#{lesson_body}"
  end

  def recent_topics
    user.lessons.order(created_at: :desc).limit(50).pluck(:title).join(', ')
  end

end
