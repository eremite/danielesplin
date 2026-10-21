class GenerateMealPlanJob < ApplicationJob

  queue_as :default

  retry_on RubyLLM::ServiceUnavailableError, attempts: 3, wait: 5.minutes

  def perform
    user.lessons.create!(body: AI.ask(meal_prompt), title: "Meal plan for #{I18n.l(plan_starts_on)}")
  end

  private

  def user
    User.find_by(role: 'father')
  end

  def plan_starts_on
    1.week.from_now.monday.to_date
  end

  def previous_entries
    EntrySearch.new(current_user: user, tag: 'ai', term: 'Meal plan for').load.entries.first(25)
  end

  def previous_meal_plans
    previous_entries.pluck(:at, :body).map { |at, body| "#{I18n.l(at.to_date)}\n#{body}" }.join("---\n")
  end

  def meal_prompt
    <<~PROMPT
      Generate a meal plan for the week starting #{plan_starts_on.strftime('%F')}.
      Continue the breakfast pattern but prefer variety for the dinners.
      Mostly use meals from previous plans but you can suggest one new thing to try if you want.
      Try to choose some dinners appropriate for the season.
      Format in html, no markdown.
      Previous meal plans: #{previous_meal_plans}
      ---
    PROMPT
  end

end
