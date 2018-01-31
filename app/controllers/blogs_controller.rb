class BlogsController < ApplicationController
# before_action動かす前にset_blogを発動させている
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.image.retrieve_from_cache! params[:cache][:image]
    # if params[:cache][:image].present?

    respond_to do |format|
      if @blog.save
        BlogMailer.blog_mail(@blog).deliver
        format.html { redirect_to blogs_path(@blog), notice: 'blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blogs_path, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'blog was successfully destroyed.' }
    end
  end
  
  def confirm
    @blog = Blog.new(blog_params)
  end

  private
   
    def blog_params 
      params.require(:blog).permit(:content,:title, :image, :image_cache)
    end
    
    def set_blog
      @blog = Blog.find(params[:id])
    end
end

