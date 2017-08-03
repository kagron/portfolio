class PostsController < ApplicationController
  
  def index
    @posts = Post.order(id: :desc).limit(10)
  end
  
  def new
    @post = Post.new
  end
  
  def edit
    @post = Post.find_by_slug(params[:slug])
  end
  
  def show
    @post = Post.find_by_slug(params[:slug])
  end
  
  def update
    # Retrieve user's profile from database
    @post = Post.find_by_slug(params[:slug])
    
    # Mass Assign edited profile attributes
    if @post.update_attributes(blog_params)
      flash[:success] = "Blog post updated!"
      # Show success message and redirect to blog
      redirect_to post_date_path(@post.year,@post.month,@post.slug)
    else
      render action: :edit
    end
  end
  
  def create
   # Mass assignment of form fields into a post object
      @post = Post.new(blog_params)
      if @post.save
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
