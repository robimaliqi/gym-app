require "test_helper"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get payment_method_selection" do
    get subscriptions_payment_method_selection_url
    assert_response :success
  end
end
