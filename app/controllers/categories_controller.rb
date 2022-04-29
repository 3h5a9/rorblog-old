class CategoriesController < ApplicationController
  before_action :set_categories, only: %i[show edit update destroy]

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category created successfully.'
      redirect_to categories_path
    else
      flash[:error] = 'Something went wrong!'
      render :new
    end
  end

  def destroy
  end

  def edit
  end

  def index
    @categories = Category.all.order('Created_at Desc')
  end

  def new
    @category = Category.new
  end

  def show
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category updated successfully.'
      redirect_to categories_path
    else
      flash[:danger] = 'Something went wrong!'
      render :edit
    end
  end

  private 
  def set_categories
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end