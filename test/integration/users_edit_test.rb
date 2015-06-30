require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nam)
  end

  test "edit should be unsuccessful" do
    get edit_user_path(@user)
    patch user_path(@user), user: { name: "",
                                    email: "user@invalid",
                                    password: "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "edit should be successful" do
    get edit_user_path(@user)
    name = "Example User"
    email = "user@example.com"
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
