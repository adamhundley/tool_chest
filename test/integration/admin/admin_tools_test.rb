require 'test_helper'

class AdminToolsTest < ActionDispatch::IntegrationTest
  def test_logged_in_admin_see_tools_index
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_tools_path

    assert page.has_content?("All Tools")
  end

  def test_defaut_user_cannot_see_admin_tools_index
    user = User.create(username: "loser",
                        password: "password",
                        role: 0)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_tools_path

    refute page.has_content?("All Tools")
    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
