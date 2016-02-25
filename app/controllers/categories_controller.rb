class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    # @category.tools = current_user_tools(current_user)
  end
end
