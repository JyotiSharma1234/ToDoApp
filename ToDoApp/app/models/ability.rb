class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    end

    if user.is_developer?
      can :manage, Task
      cannot :read, Project
      can :manage, User, id: @user.id
    end
  end
end
