require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path(:plan_id => "1")
    assert_no_difference "User.count" do
      post users_path, params: { user: { first_name: "",
                                         last_name: "",
                                         email: "user@invalid",
                                         account_level: "1",
                                         expiration_date: "31/08/2019",
                                         password: "foo",
                                         password_confirmation: "bar"} }
    end
  assert_template 'users/new'
  assert_select 'div#error_explanation'
  end

end
