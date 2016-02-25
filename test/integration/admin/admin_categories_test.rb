require 'test_helper'

class AdminCategoriesTest < ActionDispatch::IntegrationTest
  def test_logged_in_admin_sees_categories_index
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_categories_path


    assert page.has_content?("All Categories")
  end

  def test_defaut_user_cannot_see_admin_categories_index
    loser_user = User.create(username: "loser",
                        password: "password",
                        role: 0)

    ApplicationController.any_instance.stubs(:current_user).returns(loser_user)

    visit admin_categories_path

    refute page.has_content?("All Categories")
    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
