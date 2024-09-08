# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)

    if user.manager?
      can :manage, Project
    elsif user.qa?
      can :manage, Bug
      can [ :show, :update ], Project
    else
      flash[:alert] = "you don't have these rights."
    end
  end
end
