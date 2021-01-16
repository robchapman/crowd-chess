require 'test_helper'

class Api::V1::Games::BoardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_games_board_index_url
    assert_response :success
  end

end
