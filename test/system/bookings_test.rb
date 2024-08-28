require "application_system_test_case"
require 'test_helper'

class BookingsTest < ApplicationSystemTestCase
  include TestHelpers

  test "A pay as you go user books a gym class, the gym class is then addded to thier bookings" do

    register
    click_on "Pay As You Go"
    gym_class = GymClass.create!(title: "Yoga", date_and_time: Time.new(2024,7,10,9,0), price: "£20")
    Stripe::Checkout::Session.stub :create, FakeStripeSession.new(gym_class.id, payment_verification_url) do
      Stripe::Checkout::Session.stub :retrieve, FakeStripeSession.new(gym_class.id, payment_verification_url) do
        visit gym_classes_url
        click_on "Book this gym class"

        assert_text "Yoga class on 10/07/2024 at 8am has been successfully added to your Bookings"
      end
    end
  end

  test "As a pay as you go user once I book a gym class I can not book the same one again" do

    register
    click_on "Pay As You Go"
    gym_class = GymClass.create!(title: "Yoga", date_and_time: Time.new(2024,7,10,9,0), price: "£20")
    Stripe::Checkout::Session.stub :create, FakeStripeSession.new(gym_class.id, payment_verification_url) do
      Stripe::Checkout::Session.stub :retrieve, FakeStripeSession.new(gym_class.id, payment_verification_url) do
        visit gym_classes_url
        click_on "Book this gym class"

        assert_text "Yoga class on 10/07/2024 at 8am has been successfully added to your Bookings"

        visit gym_classes_url

        assert_text "This gym class has been booked"
      end
    end
  end 

  test "Cancel an existing booking" do
    register
    GymClass.create!(title: "Spin", date_and_time: Time.new(2024,2,3,14,00), price: "£20")
    visit gym_classes_url
    click_on "Book this gym class"
  
    visit bookings_url
  
    assert_text "Your Spin class on 03/02/2024 at 2pm has been successfully added to your Bookings"
    
    click_on "Cancel"
  
    assert_no_text "Your Spin class on 03/02/2024 at 2pm has been successfully added to your Bookings"
  end
end

class FakeStripeSession
  def initialize(gym_class_id, payment_verification_url)
    @gym_class_id = gym_class_id
    @payment_verification_url = payment_verification_url
  end

  def url
    "#{@payment_verification_url}?session_id=test_123"
  end

  def payment_status
    'paid'
  end

  def metadata
    OpenStruct.new(gym_class_id: @gym_class_id)
  end
end

