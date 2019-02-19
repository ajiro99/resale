require 'test_helper'

class DashBoardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dash_board_index_url
    assert_response :success
  end

end
