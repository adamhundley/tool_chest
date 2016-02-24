require 'test_helper'

class UserCanAddACategoryToAToolTest < ActionDispatch::IntegrationTest
  def test_user_can_create_a_tool_with_category
    User.create(username: "Adam", password: "pass")
    Category.create(name: "Hand Tool")
    Category.create(name: "Power Tool")

    visit '/login'
    fill_in 'Username', with: "Adam"
    fill_in 'Password', with: "pass"
    click_on "Login"

    visit new_tool_path

    fill_in "Name", with: "Screwball"
    fill_in "Price", with: "1099"
    fill_in "Quantity", with: "10"
    select "Hand Tool", from: "tool[category_id]"
    click_link_or_button "Create Tool"

    assert_equal current_path, tool_path(Tool.last)

    within(".tool_info") do
      assert page.has_content?("Screwball")
      assert page.has_content?("10.99")
      assert page.has_content?("10")
      assert page.has_content?("Hand Tool")

    end
  end
end
