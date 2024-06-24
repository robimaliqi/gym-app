require "application_system_test_case"

class PaymentTest < ApplicationSystemTestCase
  test "Sign up and pay for a monthly subscription" do
    register
    visit payment_url
    click "Pay monthly plan"
    redirect_ to stripe_payment_url
    assert_text "Monthly payment successfully set up"
  end
end