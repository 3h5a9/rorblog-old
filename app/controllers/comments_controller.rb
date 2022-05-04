class CommentsController < ApplicationController
  before_action :set_post, only: %i[create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def create
    @comment = @post.comments.create(comment_params)
    if @comment.save
      flash[:success] = 'Thanks for your valuable comments.'
      redirect_to @post
    else
      flash[:danger] = 'Something went wrong!'
      redirect_to @post
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash.now[:success] = 'Comment update successfully.'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    flash.now[:danger] = 'Comment deleted!'
    redirect_to @post
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end