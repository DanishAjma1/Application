class ProjectsController < ApplicationController
  before_action :authenticate_user!
  # before_action :require_manager, only: [ :new, :create, :destroy ]
  # before_action :authenticate_user! # Ensure the user is authenticated for all actions
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
load_and_authorize_resource except: [ :index ]

  def index
    if can? :manage, Project
    @projects = current_user.managed_projects
    if params[:query].present?
      @projects = @projects.where("name LIKE ?", "%#{params[:query]}%")
    else
      # @projects = @projects.none
    end

    @pagy, @projects = pagy(@projects)

    respond_to do |format|
      format.html # For normal page load
    format.json do
      render json: { projects: @projects.map { |project| { name: project.name, url: project_path(project) } } }
    end
    end
    elsif can? :manage, Bug
      redirect_to bugs_path
    elsif can? :read, Bug
      redirect_to bugs_path
    else
    flash[:alert] = "You are not authorized to view this page."
    redirect_to new_user_session_path
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
