class BugsController < ApplicationController
  before_action :require_qa, only: [ :new, :create, :destroy ]
    # before_action :set_bug, only: [ :show, :edit, :update, :destroy ]
    before_action :set_project
  before_action :set_bug, only: %i[edit update destroy]

  def show
  end

  def new
    @bug = Bug.new
  end

  def create
  @bug = @project.bugs.new(bug_params)
  @bug.qa = current_user

  if @bug.save
    redirect_to project_path(@project), notice: "Bug Created Successfully."
  else
    flash[:alert] = "Something went wrong while creating the bug."
    render :new
  end
  end

  def edit
  end

  def update
    if @bug.update(bug_params)
      redirect_to project_path(@project), notice: "bug Updated Successfully.."
    end
  end

  def destroy
    @bug.destroy
    redirect_to project_path, notice: "bug Deleted Successfully.."
  end
  def require_qa
    unless current_user.qa?
      flash[:alert] = "Only qas have these rights."
      redirect_to root_path
    end
  end
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_bug
    @bug = @project.bugs.find(params[:id])
  end
  private
  def bug_params
    params.require(:bug).permit(:title, :description, :priority, developer_ids: [])
  end
end
