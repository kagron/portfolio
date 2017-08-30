class ProjectsController < ApplicationController
  
  def index
    @projects = Project.all
  end
  
  def new
    @project = Project.new
  end
  
  def create
   # Mass assignment of form fields into a project object
      @project = Project.new(blog_params)
      if @project.save
         #Store success message in flash hash
         flash[:success] = "Project Posted"
         redirect_to projects_path
      else 
         # If save fails, show errors in readable sentences
         flash[:danger] = @project.errors.full_messages.join(", ")
         redirect_to projects_path
      end
  end
  
  private
   # strong params
      def blog_params
         params.require(:project).permit(:title, :description)
      end
end
