class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_categories

  def index
    @posts = Post.all.order('created_at desc')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:success] = 'Post published successfully.'
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post updated successfully.'
      redirect_to post_path(@post)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:danger] = 'Post deleted successfully.'
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :featured_image, :category_id)
  end

  def set_categories
    @categories = Category.all.order('Created_at desc')
  end
end
