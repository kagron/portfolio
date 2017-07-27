class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def edit
    @post = Post.find( params[:id] )
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def update
    # Retrieve user's profile from database
    @post = Post.find(params[:id])
    
    # Mass Assign edited profile attributes
    if @post.update_attributes(blog_params)
      flash[:success] = "Blog post updated!"
      # Show success message and redirect to profile
      redirect_to posts_path(id: params[:id])
    else
      render action: :edit
    end
  end
  
  def create
   # Mass assignment of form fields into a post object
      @post = Post.new(blog_params)
      if @post.save
         # Save the object to a database and if it goes through, send email
         title = params[:post][:name]
         content = params[:post][:content]
         
         #Store success message in flash hash
         flash[:success] = "Blog Posted"
         redirect_to posts_path
      else 
         # If save fails, show errors in readable sentences
         flash[:danger] = @post.errors.full_messages.join(", ")
         redirect_to posts_path
      end
  end
   
  private
   # To collect data from form, we need to use strong parameters
      def blog_params
         params.require(:post).permit(:title, :content)
      end
end
