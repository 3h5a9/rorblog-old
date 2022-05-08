# frozen_string_literal: true

# Post Controller
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy upvote downvote]
  before_action :set_categories
  before_action :authenticate_user!, except: %i[index show search]

  def index
    @pagy, @posts = pagy(Post.all.order('Created_at desc'), items: 3)
    @fet_post = Post.featured.last
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

  def upvote
    if current_user.voted_up_on? @post
      @post.unvote_by current_user
    else
      @post.upvote_by current_user
    end
    redirect_back(fallback_location: root_path)
  end

  def downvote
    if current_user.voted_down_on? @post
      @post.unvote_by current_user
    else
      @post.downvote_by current_user
    end
    redirect_back(fallback_location: root_path)
  end

  def search
    keyword = params[:q]
    @posts = Post.where('lower(title) LIKE ?', "%#{keyword.downcase}%")
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :featured_image, :posttype, :category_id)
  end

  def set_categories
    @categories = Category.all.order('Created_at desc')
  end
end
