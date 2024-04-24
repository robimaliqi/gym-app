require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  include TestHelpers
  # setup do
  #   @booking = bookings(:one)
  # end

  # test "visiting the index" do
  #   visit bookings_url
  #   assert_selector "h1", text: "Bookings"
  # end

  # test "should create booking" do
  #   visit bookings_url
  #   click_on "New booking"

  #   click_on "Create Booking"

  #   assert_text "Booking was successfully created"
  #   click_on "Back"
  # end

  # test "should update Booking" do
  #   visit booking_url(@booking)
  #   click_on "Edit this booking", match: :first

  #   click_on "Update Booking"

  #   assert_text "Booking was successfully updated"
  #   click_on "Back"
  # end

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
