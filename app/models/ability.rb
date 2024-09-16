# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.manager?
      # Manager can only manage projects that they created
      can :manage, Project, manager_id: user.id

    elsif user.qa?
      # QA can only view projects assigned to them
      can [ :read, :show ], Project do |project|
        project.qa_ids.include?(user.id)
      end

      # QA can manage bugs they created
      can :manage, Bug, qa_id: user.id # Assuming a `creator_id` column in the Bug model

    elsif user.developer?
      # Developers can only read/view bugs assigned to them
      can [ :read, :show ], Bug do |bug|
        bug.developers.include?(user) # Assuming the bug has many developers and a relationship
      end
    else
      flash[:alert]= "you are not Authorized User.."
    end
  end
end
