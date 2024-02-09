require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  test "log in to an account" do
    User.create(email: 'chris@example.com', password: 'password123')
    visit '/'

    click_on 'Log in'
    fill_in 'Email', with: 'chris@example.com'
    fill_in 'Password', with: 'password123'

    click_on 'Log in'
  
    assert_selector "h1", text: "My Classes"
  end
end
