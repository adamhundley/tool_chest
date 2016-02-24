require 'test_helper'

class UserCanCreateAccountTest < ActionDispatch::IntegrationTest

  def test_user_can_create_account_and_sees_name_on_dashboard
    skip  
    visit '/'
    click_on "Create Account"
    fill_in 'Username', with: "adam"
    fill_in 'Password', with: "password"

    click_on "Create Account"

    user = User.last
    assert_equal "/users/#{user.id}", current_path
    assert page.has_content? "Welcome, #{user.username}"
  end
end
