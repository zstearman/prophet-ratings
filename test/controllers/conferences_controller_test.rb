require 'test_helper'

class ConferencesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:zach)
  end
  
  test "should get index" do
    log_in_as(@user)
    get conferences_path
    assert_response :success
  end

end
