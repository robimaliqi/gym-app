require "application_system_test_case"

class SubscriptionFlowTest < ApplicationSystemTestCase
  include TestHelpers

  test "user asked to choose payment method after login" do
    register

    assert_text "Choose your payment method"
    assert_selector "button", text: "Pay Monthly"
    assert_selector "button", text: "Pay As You Go"
  end

  test "user redirected to Stripe checkout for monthly subscription" do
    register

    assert_text "Choose your payment method"
    assert_selector "button", text: "Pay Monthly"
    assert_selector "button", text: "Pay As You Go"
    
    click_on "Pay Monthly"

    assert_current_path(%r{/c/pay})
  end
  
  test "monthly user logs in and does not see gym class prices" do
    user = User.create!(email: 'chris@example.com', password: 'password123')
    Subscription.create(user_id: user)

    login

    expect(page).not_to have_content('price: £20')
  end

  # test "user redirected to Stripe checkout for pay as you go subscription" do
  #   register

  #   assert_text "Choose your payment method"
  #   assert_selector "button", text: "Pay Monthly"
  #   assert_selector "button", text: "Pay As You Go"
    
  #   click_on "Pay As You Go"

  #   assert_current_path(%r{/c/pay})
  # end
end