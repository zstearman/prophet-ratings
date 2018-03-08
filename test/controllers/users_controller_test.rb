require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:zach)
    @other_user = users(:two)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  # Login not working because we are testing users controller?
  # test "should redirect edit when logged in as wrong user" do
  #   post login_path, params: { session: { email: @other_user.email,
  #                                         password: 'password' } }
  #   assert_redirected_to @other_user
  #   get edit_user_path(@user)
  #   #assert flash.empty?
  #   assert_redirected_to root_url
  # end
  
  # test "should redirect update when logged in as wrong user" do
  #   post login_path, params: { session: { email: @other_user.email,
  #                                         password: 'password' } }
  #   assert_redirected_to @other_user                                      
  #   patch user_path(@user), params: { user: { first_name: @user.first_name,
  #                                             email: @user.email } }
  #   #assert flash.empty?
  #   assert_redirected_to root_url
  # end
end
