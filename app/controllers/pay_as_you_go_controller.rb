class PayAsYouGoController < ApplicationController

  def pay_as_you_go
    gym_class = GymClass.find(params[:gym_class_id])
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'gbp',
          product_data: {
            name: gym_class.title,
          },
          unit_amount: (gym_class.price * 100).to_i,
        },
        quantity: 1,
      }],
      mode: 'payment',
      metadata: { gym_class_id: gym_class.id },
      cancel_url: gym_classes_url,
      success_url: "#{payment_verification_url}?session_id={CHECKOUT_SESSION_ID}"
    })
    redirect_to session.url, allow_other_host: true
  end
end