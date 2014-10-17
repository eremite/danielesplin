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
        can :manage, Post
        can :manage, :report
        can :manage, User
        can :manage, Comment
        can :manage, SavedFile
        can :manage, SavedFileCategory
        can :manage, NutritionalPost
        can :manage, InventoryItem
        if user.father?
          can :manage, Thought
        else
          can :read, Thought
        end
      elsif user.grandparent?
        can :read, Photo
        can :read, Entry, user_id: User.where(role: 'baby').pluck(:id)
        can :read, Entry, user_id: User.where(role: 'father').pluck(:id), at: Time.at(0)..Time.zone.parse('2000-01-01')
        can :read, Post
      else
        can :read, Photo
        can :read, Post
      end
    end
    can :read, NutritionalPost
    can :index, :page
    if format == 'rss'
      can :index, Post
    end
  end

end
