class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    end

    if user.developer?
      can :manage, Task
      cannot :read, Project
      can :manage, User, id: @user.id
    end

    if user.project_manager?
      can :manage, Project
      can :manage, Task
      can :manage, User, id: @user.id
    end
  end
end
