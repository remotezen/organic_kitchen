require 'test_helper'
#rails test:models

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User",
     email: "user@example.com",
     password: "foobar",
     password_confirmation: "foobar")
  end
  #//////////////////////////////
  #user and name validations
  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name =  "a" * 51
    assert_not @user.valid?
  end
  #///////////////////////////////
  #email validations
  test "email should not be too long" do
    @user.email =  "a" * 256
    assert_not @user.valid?
  end

  test "email validation should accept valid format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
   valid_addresses.each do |v|
     @user.email = v
     assert @user.valid?, "#{v.inspect} should be valid"
   end
  end
  test "email validation should reject invalid addressess" do
     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
     invalid_addresses.each do |v|
       @user.email = v
       assert_not @user.valid?, "#{v.inspect} should be invalid"
     end
  end
  test "email address should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "FoO@ExAmPle.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email

  end
  #////////////////////////
  #password validations
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "A" * 5
    assert_not @user.valid?
  end

end