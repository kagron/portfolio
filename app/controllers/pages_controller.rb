class PagesController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    
    def index
        @post = Post.last
        @about = About.last
    end
    
    def edit
        @post = Post.last
        @about = About.last
        if !@about.present?
            # If there is no front page, change the page to the new page instead
            # It will look the same
            @about = About.new
          end
    end

    def create
        # Retrieve post from url
        @about = About.new(home_params)

        # Mass Assign edited post attributes
        if @about.save
            flash[:success] = "Home Page updated!"
            # Show success message and redirect to home page
            redirect_to root_path
        else
            # if something failed, return back to the edit page
            render action: :edit
        end

    end
    
    def update
        # Retrieve post from database
        @about = About.last
        
        # Mass Assign edited post attributes
        if @about.update_attributes(home_params)
          flash[:success] = "Home Page updated!"
          # Show success message and redirect to blog
          redirect_to root_path
        else
          render action: :edit
        end
    end
    
    private
    # strong params
      def home_params
         params.require(:about).permit(:title, :content, :resume_file)
      end
end
