require 'test_helper'

class TeamsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:zach)
    @user = users(:two)
    @team = teams(:sooners)
  end
  
  test "should get team show page" do
    get team_path(@team)
    assert_response :success
  end
  
  test "should allow admin to see index page" do
    log_in_as @admin
    get teams_path
    assert_response :success
  end

  test "should redirect edit to root if not admin" do
    log_in_as @user
    get edit_team_path(@team)
    assert_redirected_to root_url
  end
end
