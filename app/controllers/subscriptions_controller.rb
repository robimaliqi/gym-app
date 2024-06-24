class SubscriptionsController < ApplicationController
  def payment_method_selection
  end

  def pay_as_you_go
  end

  def pay_monthly
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
      price_data: {
        currency: 'gbp',
        unit_amount: '3000',
        product_data: {
          name: 'Gym membership'
        },
        recurring: {
          interval: 'month'
        }
      },
      quantity: 1,
      }],
      mode: 'subscription',
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )
  
    redirect_to @session.url, allow_other_host: true
  end
end
