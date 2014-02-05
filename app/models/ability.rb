class Ability
  include CanCan::Ability

  def initialize(user, format)
    if user
      can :index, :search
      can :update, User, id: user.id
      can :manage, Comment, user_id: user.id
      if user.parent?
        can :manage, Photo
        can :manage, Entry
        can :manage, :blog_post
        can :manage, :report
        can :manage, User
        can :manage, Comment
        can :manage, SavedFile
        if user.father?
          can :manage, Thought
        else
          can :read, Thought
        end
      elsif user.grandparent?
        can :read, Photo
        can :read, Entry, public: true
        can :read, Entry, public: false, user_id: User.where(role: 'baby').pluck(:id)
        can :read, Entry, public: false, user_id: User.where(role: 'father').pluck(:id), at: Time.at(0)..Time.zone.parse('2000-01-01')
        can :index, :blog_post
      else
        can :read, Photo
        can :read, Entry, public: true
        can :index, :blog_post
      end
    end
    can :index, :page
    if format == 'rss'
      can :index, :blog_post
    end
  end

end
