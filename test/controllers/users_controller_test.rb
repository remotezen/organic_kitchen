require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fred)
    #code
  end
  test "should get new" do
    get users_new_url
    assert_response :success
  end
  test "should redirect update when not logged in" do
    patch user_path(@user), params: {user: {name: @user.name,
                                            email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
