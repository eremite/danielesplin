class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :index, :page
    elsif %w(Daniel Erika).include?(user.name)
      can :manage, :all
    else
      can :read, Photo
      can :read, Entry, { public: true }
    end
  end

end
