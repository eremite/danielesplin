class Ability
  include CanCan::Ability

  def initialize(user, format)
    if user
      if user.daniel? || user.erika?
        can :manage, Photo
        can :manage, Entry, user_id: user.id
        can :manage, Entry, public: true
        can :manage, :blog_post
        can :manage, :report
        can :manage, User
        if user.daniel?
          can :manage, Thought
        else
          can :read, Thought
        end
      else
        can :read, Photo
        can :read, Entry, public: true
        can :index, :blog_post
      end
      can :manage, Comment, user_id: user.id
      can :update, User, id: user.id
      can :index, :search
    end
    can :index, :page
    if format == 'rss'
      can :index, :blog_post
    end
  end

end
