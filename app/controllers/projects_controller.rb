class ProjectsController < ApplicationController
  # before_action :authenticate_user!
  before_action :require_manager, only: [ :new, :create, :destroy ]
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  def index
    if current_user.manager?
  @pagy, @projects = pagy(current_user.managed_projects)

    elsif current_user.qa?
  @pagy, @projects = pagy(current_user.assigned_projects)

    elsif current_user.developer?
  @pagy, @bugs = pagy(current_user.assigned_bugs)
    end
  end

  def search
    @projects = current_user.managed_projects.where("name LIKE ?", "%#{params[:query]}%")
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("projects-table-body", "index", locals: { projects: @projects }) }
      format.html { render "index", locals: { projects: @projects } }
      @pagy, @projects = pagy(@projects)
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
