class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    if (!params[:year].present? && !params[:month].present?)
        @posts = Post.order(id: :desc).paginate(page: params[:page], per_page: 10)
    elsif params[:month].present?
        @posts = Post.where("extract(month  from created_at) = ? AND extract(year  from created_at) = ?", params[:month], params[:year]).order(id: :desc).paginate(page: params[:page], per_page: 10)
    elsif params[:year].present?
        @posts = Post.where("extract(year  from created_at) = ?", params[:year]).order(id: :desc).paginate(page: params[:page], per_page: 10)
    end

    @months = Post.pluck(:created_at).map{|i|  i.strftime("%B %Y")}.uniq
  end
  
  def new
    @post = Post.new
  end
  
  def edit
    @post = Post.find_by_slug(params[:slug])
  end
  
  def show
    @post = Post.find_by_slug(params[:slug])
    @months = Post.pluck(:created_at).map{|i|  i.strftime("%B, %Y")}.uniq
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
  def destroy
      @post = Post.find_by_slug(params[:slug])
      @post.destroy
      flash[:success] = "Blog Post Deleted!"
      redirect_to posts_path
  end
   
  private
   # strong params
      def blog_params
         params.require(:post).permit(:title, :content)
      end
end
