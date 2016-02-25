require 'test_helper'

class AdminCanCrudCategoriesTest < ActionDispatch::IntegrationTest
  def test_logged_in_admin_sees_create_categories
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_categories_path

    click_on "Create Category"

    fill_in "Name", with: "Test Category"
    click_link_or_button "Create Category"

    assert admin_categories_path, current_path

    assert page.has_content?("Test Category")
  end

  def test_logged_in_admin_can_edit_categories
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    Category.create(name: "Category1")
    Category.create(name: "Category2")
    Category.create(name: "Category3")

    visit admin_categories_path
    click_on "Category2"
    click_on "Edit"
    fill_in "Name", with: "New Name"
    click_link_or_button "Update Category"

    assert page.has_content?("New Name")
  end

  def test_logged_in_admin_can_delete_categories
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    Category.create(name: "Category1")
    Category.create(name: "Category2")
    Category.create(name: "Category3")

    visit admin_categories_path
    click_on "Category1"
    click_on "Delete"

    refute page.has_content?("Category1")
  end
end
