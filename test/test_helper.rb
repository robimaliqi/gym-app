ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module TestHelpers
  def register
    visit '/'
    click_on 'Sign up'
    fill_in 'First name', with: 'Chris'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Email', with: 'chris@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_on 'Sign up'
    assert_selector "h1", text: "My Classes"
  end
end