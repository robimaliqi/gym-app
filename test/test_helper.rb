ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'minitest/autorun'

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
  end

  def login
    User.create(email: 'chris@example.com', password: 'password123')
    visit '/'
    click_on 'Log in'
    fill_in 'Email', with: 'chris@example.com'
    fill_in 'Password', with: 'password123'
    click_on 'Log in'
    assert_selector "h1", text: "Home#index"
  end
end

is_ci = ENV.fetch('IS_CI', false)

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless no-sandbox disable-gpu disable-dev-shm-usage],
    binary: '/usr/bin/google-chrome'
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:
  )
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DRIVER = if ENV["IS_CI"]
    :headless_chrome
  else
    :chrome
  end
  puts DRIVER

  driven_by :selenium, using: DRIVER, screen_size: [1400, 1400]
end
