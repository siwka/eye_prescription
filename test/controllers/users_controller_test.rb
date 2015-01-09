require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user       = users(:customer)
    @other_user = users(:eagle)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up"
  end

end
