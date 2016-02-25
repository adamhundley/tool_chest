class Category < ActiveRecord::Base
  has_many :tools, dependent: :destroy

  def current_user_tools(current_user)
    tools.where(user_id: current_user.id)
  end
end
