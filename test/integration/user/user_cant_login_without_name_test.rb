require 'test_helper'

class UserCantLoginWithoutNameTest < ActionDispatch::IntegrationTest
  def test_a_created_user_cant_login_without_username
    User.create(username: "adam", password: "password")

    visit '/login'
    fill_in 'Username', with: ""
    fill_in 'Password', with: "password"

    click_on "Login"

    assert_equal "/login", current_path
    assert page.has_content? "Login information invalid"

  end
end
