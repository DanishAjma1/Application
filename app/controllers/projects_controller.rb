class ProjectsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :require_manager, only: [ :new, :create, :destroy ]
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  def index
    if can? :manage, Project
    @projects = current_user.managed_projects
    @projects = @projects.where("name LIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @projects = pagy(@projects)

    # Render the entire index page for a normal HTML request (since we're not using Turbo)
    respond_to do |format|
      format.html { render :index } # Full page with search results and pagination
    end
    elsif can?(:update, Project) && can?(:manage, Bug)
      redirect_to bugs_path # Redirect to the bugs index for QA
    elsif can? :update, Bug
      redirect_to bugs_path
    end
  end
  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.manager = current_user
    if @project.save
      redirect_to @project, notice: "Project Created Successfully.."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project Updated Successfully.."
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project Deleted Successfully.."
  end

  def require_manager
    unless current_user.manager?
      flash[:alert] = "Only managers have these rights."
      redirect_to root_path
    end
  end

  def set_project
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :status, qa_ids: [])
  end
end
