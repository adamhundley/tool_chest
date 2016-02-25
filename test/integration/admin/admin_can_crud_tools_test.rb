require 'test_helper'

class Admin::AdminCanCrudToolsTest < ActionDispatch::IntegrationTest
  def test_logged_in_admin_creates_a_tool
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    User.create(username: "user",
                password: "password",
                role: 0)

    Category.create(name: "Hand Tool")

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_tools_path

    click_on "Create Tool"
    fill_in "Name", with: "Test Tool"
    fill_in "Quantity", with: 10
    fill_in "Price", with: 1000
    select "Hand Tool", from: "tool[category_id]"
    select "user", from: "tool[user_id]"

    click_link_or_button "Create Tool"

    assert admin_tools_path, current_path

    assert page.has_content?("Test Tool")
    assert page.has_content?("Hand Tool")
    assert page.has_content?("user")
  end

  def test_logged_in_admin_can_edit_tools
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    category = Category.create(name: "Hand Tool")
    Category.create(name: "Other")
    user = User.create(username: "user",
                password: "password",
                role: 0)
    User.create(username: "user2",
                password: "password",
                role: 0)

    Tool.create(name: "Hammer", price: 1000, quantity: 10, category_id: category.id, user_id: user.id)

    visit admin_tools_path

    click_link_or_button "Hammer"
    click_link_or_button "Edit"

    fill_in "Name", with: "Screw"
    fill_in "Quantity", with: 100
    fill_in "Price", with: 1500
    select "Other", from: "tool[category_id]"
    select "user2", from: "tool[user_id]"
    click_link_or_button "Update Tool"

    assert page.has_content?("Screw")
    assert page.has_content?("user2")
    assert page.has_content?("Other")
  end

  def test_logged_in_admin_can_delete_tools
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    category = Category.create(name: "Hand Tool")
    user = User.create(username: "user",
                password: "password",
                role: 0)
    Tool.create(name: "Hammer", price: 1000, quantity: 10, category_id: category.id, user_id: user.id)

    visit admin_tools_path
    click_link_or_button "Hammer"
    click_on "Delete"

    refute page.has_content?("Hammer")
  end
end
