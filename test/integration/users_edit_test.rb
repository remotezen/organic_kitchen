require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fred)
  end
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: { name: "",
                                            password: "foo",
                                            password_confirmation: "bar"
                                            }
                                    }
  assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = " Foo Bar"
    email = "foo@bar.com"

    assert_template 'users/edit'
    patch user_path(@user), params: {user: { name: name,
                                             email: email,
                                             password: "",
                                             password_confirmation: ""
                                            }
                                    }
  assert_not flash.empty?
  @user.reload
  assert_equal name, @user.name
  assert_equal email, @user.email
  end
  # test "the truth" do
  #   assert true
  # end
end
