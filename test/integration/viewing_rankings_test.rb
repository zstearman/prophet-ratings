require 'test_helper'

class ViewingRankingsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:zach)
  end
  
  test "logged in user should be able to view rankings" do
    log_in_as @user
    get root_url
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'static_pages/dashboard'
    assert_select 'a[href=?]', rankings_path, "Complete Rankings"
    get rankings_path
    assert_response :success
    assert_template 'team_seasons/index'
  end
  
  test "non-logged in user should not be able to view rankings" do
    get rankings_path
    assert_response :redirect
    assert_not flash.empty?
    follow_redirect!
    assert_template 'sessions/new'
  end
end
