require 'test_helper'

class UserCanLoginTest < ActionDispatch::IntegrationTest
  def test_a_created_user_can_login
    user = User.create(username: "adam", password: "password")

    visit '/login'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password

    click_on "Login"

    assert_equal "/users/#{user.id}", current_path
    assert page.has_content? "Welcome, #{user.username}"

  end
end
