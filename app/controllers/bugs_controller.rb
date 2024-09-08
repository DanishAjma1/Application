class BugsController < ApplicationController
  before_action :require_qa, only: [ :index, :new, :create, :edit, :update, :destroy ]

  def index
      # if current_user.qa?
      @bugs = current_user.created_bugs
    # else
    # Handle other roles if necessary, or show an empty list
    # @bugs = bug.none
    # end
  end

  def show
    @bug=Bug.find(params[:id])
  end

  def new
    @bug = Bug.new
  end

  def create
    @bug=current_user.managed_bugs.build(bug_params)
    if @bug.save
      redirect_to @bug, notice: "bug Created Successfully.."
    else
      render :new
    end
  end

  def edit
    @bug=Bug.find(params[:id])
  end

  def update
    @bug=Bug.find(params[:id])
    if @bug.update(bug_params)
      redirect_to @bug, notice: "bug Updated Successfully.."
    end
  end

  def destroy
    @bug=bug.find(params[:id])
    @bug.destroy
    redirect_to bugs_path, notice: "bug Deleted Successfully.."
  end
  def require_qa
    unless current_user.qa?
      flash[:alert] = "Only qas have these rights."
    end
  end
  private
  def bug_params
    params.require(:bug).permit(:name, :description, :status)
  end
end
