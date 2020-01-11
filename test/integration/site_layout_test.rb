require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
 
  test "layout links" do
    # Logged out link functionality
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    # While logged in
    @user = users(:archer)
    log_in_as(@user)
    get root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", '#'
    # Note: not able to assert the selection of "Profile" and "Settings" in this directory
    assert_select "a[href=?]", logout_path
    # assert_select "title", full_title("Users")...looking to assert correct string
    get users_path
    assert_select "title", full_title("All users")
    
  end
end
