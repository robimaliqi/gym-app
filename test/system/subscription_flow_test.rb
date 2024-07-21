require "application_system_test_case"

class SubscriptionFlowTest < ApplicationSystemTestCase
  include TestHelpers

  test "user asked to choose payment method after login" do
    register

    assert_text "Choose your payment method"
    assert_selector "button", text: "Pay Monthly"
    assert_selector "a", text: "Pay As You Go"
  end

  test "user redirected to Stripe checkout for monthly subscription" do
    register

    assert_text "Choose your payment method"
    assert_selector "button", text: "Pay Monthly"
    assert_selector "a", text: "Pay As You Go"
    
    click_on "Pay Monthly"

    assert_current_path(%r{/c/pay})
  end
  
  test "monthly user logs in and does not see gym class prices" do
    user = User.create!(email: 'chris@example.com', password: 'password123')
    Subscription.create(user_id: user.id)
    GymClass.create!(title: "Yoga", date_and_time: Time.new(2024,2,5,10,00), price: "20")

    login
    click_on "Gym classes"
    assert_no_text "£20"
  end

  test "when a Pay as you go user logs in they are able to book a singular Gym class" do
    user = User.create!(email: 'chris@example.com', password: 'password123')
    GymClass.create!(title: "Yoga", date_and_time: Time.new(2024,2,5,10,00), price: "20")

    login

    click_on "Gym classes"
    click_on "Book this gym class"
    assert_current_path(%r{/c/pay})
    
  end
end