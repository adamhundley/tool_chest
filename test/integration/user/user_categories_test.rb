require 'test_helper'

class UserCategoriesTest < ActionDispatch::IntegrationTest
  def test_logged_in_user_sees_categories_index
    user = User.create(username: "adam",
                        password: "password",
                        role: 0)

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    Category.create(name: "Category1")
    Category.create(name: "Category2")

    visit categories_path

    assert page.has_content?("Category1")
    assert page.has_content?("Category2")
  end

  def test_logged_in_user_can_see_tools_in_categories
    user = User.create(username: "adam",
                        password: "password",
                        role: 0)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    category1 = Category.create(name: "Category1")
    category2 = Category.create(name: "Category2")
    Category.create(name: "Category3")

    tool1 = Tool.create(name: "Screwball", quantity: 10, price: 10000)
    tool2 = Tool.create(name: "Hammer", quantity: 10, price: 10000)
    tool3 = Tool.create(name: "Ballpin", quantity: 10, price: 10000)

    category1.tools << tool1
    category1.tools << tool2
    category2.tools << tool3
    user.tools << tool1

    visit categories_path

    click_on "Category1"
    assert page.has_content?("Category1")
    assert page.has_content?("Screwball")
    refute page.has_content?("Hammer")
    refute page.has_content?("Ballpin")

    visit categories_path

    click_on "Category3"
    assert page.has_content?("You have no tools in Category3")
  end
end
