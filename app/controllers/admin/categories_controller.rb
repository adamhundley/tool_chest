class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def create
    @category = Category.create(category_params)
    flash[:notice] = "Category Created!"
    redirect_to admin_categories_path


    # @tool = Tool.new(tool_params)
    # @tool.user = current_user
    # if @tool.save
    #   flash[:notice] = "Tool created!"
    #   session[:most_recent_tool_id] = Tool.find(@tool.id)
    #   redirect_to @tool
    # else
    #   flash[:error] = @tool.errors.full_messages.join(", ")
    #   render :new
    # end
    #
  end

  def destroy
    Category.destroy(params[:id])
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
