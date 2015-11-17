class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :update, :destroy, :edit, to: :modify
    
    if user.is_admin?
      can :manage, :all
    elsif user.is_user?
      can :modify, Group, user_id: user.id
      can :modify, Trip, user_id: user.id
      can :read, :all
    else
      can :read, :all
    end
  end
end
