require 'test_helper'

class UserViewsIndexPageTest < ActionDispatch::IntegrationTest
  def test_user_views_index_page_and_only_sees_their_tools
    user = User.create(username: "Adam", password: "pass", role: 0)
    tool1 = Tool.create(name: "Screwball", quantity: 10, price: 10000)
    Tool.create(name: "Hammer", quantity: 10, price: 10000)
    tool3 = Tool.create(name: "Ballpin", quantity: 10, price: 10000)

    user.tools << tool1
    user.tools << tool3

    assert_equal 2, user.tools.count

    visit '/login'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on "Login"
    visit tools_path

    assert page.has_content?("Screwball")
    assert page.has_content?("Ballpin")
    refute page.has_content?("Hammer")
  end
end
