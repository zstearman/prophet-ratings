require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :success
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Prophet Ratings - NCAA Basketball Predictive Analytics"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Prophet Ratings - NCAA Basketball Predictive Analytics"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Prophet Ratings - NCAA Basketball Predictive Analytics"
  end
  
  test "should get plan page" do
    get plans_path
    assert_response :success
    assert_select "title", "Pick Your Plan | Prophet Ratings - NCAA Basketball Predictive Analytics"
  end
end
