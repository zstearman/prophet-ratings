require 'test_helper'

class TeamSeasonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get team_seasons_index_url
    assert_response :success
  end

end
