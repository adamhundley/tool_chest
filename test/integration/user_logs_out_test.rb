require 'test_helper'

class UserLogsTest < ActionDispatch::IntegrationTest
  def test_a_created_user_can_login
    user = User.create(username: "adam", password: "password")

    visit '/login'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: "password"
    click_on "Login"
    visit "/users/#{user.id}"
    click_on "Logout"

    assert_equal "/", current_path
    refute page.has_content? "Welcome, #{user.username}"
  end
end
