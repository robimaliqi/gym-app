require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
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