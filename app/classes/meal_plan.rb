class MealPlan

  include ActiveModel::Model

  attr_accessor :user

  def save!
    user.lessons.create!(meal_plan_params)
  end

  private

  def meal_plan_params
    { body: AI.ask(meal_prompt), title: "Meal plan for #{I18n.l(plan_starts_on)}" }
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
      Continue breakfast patterns but dinners should always be different from the previous week.
      Never use the same protein as the previous day.
      A rough guide is 1-2 chicken dinners, 1 fish, 1 ground beef, occasional ground pork and the rest vegetarian.
      Avoid fish and beef on Saturdays.
      1-2 pasta, 1 rice, occasional potatoes, rarely lentils.
      Available supplies include oven, range, microwave, blender, instant pot, and slow cooker.
      The meal for Tuesday should either be fast and easy or able to be prepared previously.
      Format in html, no markdown.
      Previous meal plans: #{previous_meal_plans}
      ---
    PROMPT
  end

end
