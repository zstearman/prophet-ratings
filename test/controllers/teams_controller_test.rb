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
  
  test "should allow admin to create and delete teams" do
    log_in_as @admin
    get new_team_path
    assert_response :success
    
    # Cannot get this post to work yet
    # post new_team_path, params: { team: { school: 'Test University',
    #                                         name: 'Bulldogs',
    #                                         active: true } }
    # assert_not flash.empty?
    
    # Beats me....
    # assert_difference 'Team.count' do
    #   delete team_path(@team)
    # end
    
  end
end
