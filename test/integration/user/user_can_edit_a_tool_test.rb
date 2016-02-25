require 'test_helper'

class UserCanEditAToolTest < ActionDispatch::IntegrationTest
  # def test_a_user_can_edit_an_existing_tool
  #   skip
  #   tool = Tool.create(name: "Screwball", quantity: 10, price: 10000)
  #
  #   visit edit_tool_path(tool)
  #
  #   fill_in "Name", with: "Newtool"
  #   fill_in "Quantity", with: "20"
  #   fill_in "tool[price]", with: "5000"
  #
  #   click_link_or_button "Update Tool"
  #
  #   assert_equal current_path, tool_path(tool.id)
  #
  #   within(".tool_info") do
  #     assert page.has_content?("Newtool")
  #     assert page.has_content?("20")
  #     assert page.has_content?("50.0")
  #   end
  # end
end
