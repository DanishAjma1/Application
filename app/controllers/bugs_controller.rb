class BugsController < ApplicationController
    before_action :set_project, only: [ :new, :create, :destroy, :edit, :update ]
  before_action :set_bug, only: %i[edit update destroy]
  load_and_authorize_resource


  def index
    if can? :manage, Bug
      @projects = current_user.assigned_projects
      if params[:query].present?
        @projects = @projects.where("name LIKE ?", "%#{params[:query]}%")
      end
      @pagy, @projects = pagy(@projects)
      render "projects/index"

    else
      @pagy, @bugs = pagy(current_user.assigned_bugs)
      @bugs = @bugs.where("title LIKE ?", "%#{params[:query]}%")
      @pagy, @bugs=pagy(@bugs)
    respond_to do |format|
      format.html { render :index } # Full page with search results and pagination
    end
    end
  end

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
