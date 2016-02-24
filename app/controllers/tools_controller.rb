class ToolsController < ApplicationController
  def index
    @tools = current_user.tools
  end

  def show
    find_tool
  end

  def new
    @tool = Tool.new
    @categories = Category.all
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @categories = Category.all
    @tool = Tool.find(params[:id])
    if @tool.update(tool_params)
      redirect_to tool_path(@tool)
    else
      render :edit
    end
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user = current_user
    if @tool.save
      flash[:notice] = "Tool created!"
      session[:most_recent_tool_id] = Tool.find(@tool.id)
      redirect_to @tool
    else
      flash[:error] = @tool.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    Tool.destroy(params[:id])
    redirect_to tools_path
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :price, :quantity, :category_id)
  end

  def find_tool
    @tool = Tool.find(params[:id])
  end
end
