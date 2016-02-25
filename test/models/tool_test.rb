require "test_helper"

class ToolTest < ActiveSupport::TestCase
  should belong_to :category
  should belong_to :user
  should_not allow_value("").for(:name)
end
