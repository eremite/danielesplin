class MealPlansController < ApplicationController

  def create
    MealPlan.new(user: Current.user).save!
    redirect_to :lessons
  end

  private

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end

end
