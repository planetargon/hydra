class Admin::ProjectsController < Admin::ApplicationController
  before_filter :fetch_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @releases = @project.releases.order("deployed_at DESC")
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])

    if @project.save
      add_message "Project was created successfully."
      redirect_to admin_projects_path
    else
      add_error "There was an error creating the project. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      add_message "Project was updated successfully."
      redirect_to admin_projects_path
    else
      add_error "There was an error updating the project. Please try again."
      render :edit
    end
  end

  def destroy
    if @project.destroy
      add_message "Project #{@project.name} was deleted successfully."
    else
      add_error "There was an error deleting project #{@project.name}. Please try again."
    end
    redirect_to admin_projects_path
  end

  protected
  def fetch_project
    @project = Project.find(params[:id])
  end
end
