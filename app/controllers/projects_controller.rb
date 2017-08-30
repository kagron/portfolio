class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @projects = Project.all
  end
  
  def new
    @project = Project.new
  end
  
  def create
   # Mass assignment of form fields into a project object
      @project = Project.new(project_params)
      if @project.save
         #Store success message in flash hash
         flash[:success] = "Project Posted"
         redirect_to projects_path
      else 
         # If save fails, show errors in readable sentences
         flash[:danger] = @project.errors.full_messages.join(", ")
         render action: :new
      end
  end
  
  def show
    @project = Project.find_by_slug(params[:slug])
  end 
  
  def edit
    @project = Project.find_by_slug(params[:slug])
  end
  
  def update
    # Retrieve project from database
    @project = Project.find_by_slug(params[:slug])
    
    # Mass Assign edited project attributes
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated!"
      # Show success message and redirect to blog
      redirect_to project_slug_path(@project.slug)
    else
      render action: :edit
    end
  end
  
  def destroy
      @project = Project.find_by_slug(params[:slug])
      @project.destroy
      flash[:success] = "Project Deleted!"
      redirect_to projects_path
  end
  
  private
   # strong params
      def project_params
         params.require(:project).permit(:avatar, :title, :description)
      end
end
