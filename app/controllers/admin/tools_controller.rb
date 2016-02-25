class Admin::ToolsController < Admin::BaseController
  def index
    @tools = Tool.all
  end

  def new
    @tool = Tool.new
    @categories = Category.all
    @users = User.all
  end

  def create
    @tool = Tool.create(tool_params)
    flash[:notice] = "Tool Created!"
    redirect_to admin_tools_path
  end

  def show
    @tool = Tool.find(params[:id])
  end

  def edit
    @tool = Tool.find(params[:id])
    @categories = Category.all
    @users = User.all
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update(tool_params)
      redirect_to admin_tools_path
    else
      render :edit
    end
  end

  def destroy
    Tool.destroy(params[:id])
    redirect_to admin_tools_path
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :price, :quantity, :user_id, :category_id)
  end
end
