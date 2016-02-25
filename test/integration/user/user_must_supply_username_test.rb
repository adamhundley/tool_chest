require 'test_helper'

class UserMustSupplyUsernameTest < ActionDispatch::IntegrationTest
  def test_user_cant_create_account_with_no_username
    visit '/'
    click_on "Create Account"
    fill_in 'Username', with: ""
    fill_in 'Password', with: "password"

    click_on "Create Account"

    assert_equal "/users", current_path
    assert page.has_content? "Username can't be blank"
  end
end
