class ToolsController < ApplicationController
  def index
    @tools = current_user.tools
  end

  def show
    find_tool
    if current_user.tools.include?(@tool)
    else
      flash[:alert] = "You don't have this tool!"
      redirect_to tools_path
    end
  end

  def new
    @tool = Tool.new
    create_categories
  end

  def edit
    @tool = Tool.find(params[:id])
    create_categories
  end

  def update
    create_categories
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

  def create_categories
    Category.create(name: "Hand Tool")
    Category.create(name: "Power Tool")
    @categories ||= Category.all
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :price, :quantity, :category_id)
  end

  def find_tool
    @tool = Tool.find(params[:id])
  end
end
