require 'test_helper'

class UserCantViewOtherToolsTest < ActionDispatch::IntegrationTest
  def test_user_views_show_page_for_their_tools
    user = User.create(username: "Adam", password: "pass", role: 0)
    tool1 = Tool.create(name: "Screwball", quantity: 10, price: 10000)
    tool2 = Tool.create(name: "Hammer", quantity: 10, price: 10000)
    tool3 = Tool.create(name: "Ballpin", quantity: 10, price: 10000)

    user.tools << tool1
    user.tools << tool3

    visit '/login'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on "Login"

    visit tool_path(tool1)

    assert page.has_content?("Screwball")

    visit tool_path(tool2)
    refute page.has_content?("Hammer")
  end
end
