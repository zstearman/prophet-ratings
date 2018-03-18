require 'test_helper'

class TeamSeasonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rankings_path
    assert_response :success
  end

end
