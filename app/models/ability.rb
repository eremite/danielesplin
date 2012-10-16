class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if %w(Daniel Erika).include?(user.name)
        can :manage, Photo
        can :manage, Entry, user_id: user.id
      else
        can :read, Photo
        can :read, Entry, { public: true }
      end
      can :update, User, id: user.id
    end
    can :index, :page
  end

end
