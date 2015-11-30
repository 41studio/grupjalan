class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :update, :destroy, :edit, to: :modify
    alias_action :index, :show, :posts, :members, :search, to: :read
    alias_action :upvote, :downvote, to: :votes
    
    if user.is_admin?
      can :manage, :all
    elsif user.is_user?
      can :create, [Group, Post, Comment]
      can :modify, [Post, Trip, Group, Comment], user_id: user.id
      can :join, [Group, Trip]
      can :votes, Post
      can :read, :all
    else
      can :read, :all
    end
  end
end
