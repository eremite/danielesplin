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
        can :manage, InventoryItem
        can :manage, PostPhoto
        can :manage, :print_batch
        if user.father?
          can :manage, Note
        end
      else
        can :read, Photo
        can :read, Post
      end
    end
    can :index, :page
    if format == 'rss'
      can :index, Post
    end
  end

end
