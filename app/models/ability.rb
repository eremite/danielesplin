class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if %w(daniel@danielesplin.org erika@danielesplin.org).include?(user.email)
        can :manage, Photo
        can :manage, Entry, user_id: user.id
        can :manage, Entry, public: true
        can :manage, :blog_post
      else
        can :read, Photo
        can :index, :blog_post
      end
      can :update, User, id: user.id
    end
    can :index, :page
  end

end
