require "application_system_test_case"

class GymClassesTest < ApplicationSystemTestCase
  include TestHelpers

  test "See all current available classes" do
    GymClass.create!(title: "Yoga", date_and_time: Time.new(2024,2,5,10,00), price: "£20")
    GymClass.create!(title: "Zumba", date_and_time: Time.new(2024,2,5,10,00), price: "£20")
    GymClass.create!(title: "Pillates", date_and_time: Time.new(2024,2,5,10,00), price: "£20")

    visit gym_classes_url

    assert_text "Yoga"
    assert_text "Zumba"
    assert_text "Pillates"
  end

  test "Add a class to my bookings when I have registered and logged in" do
    register
    GymClass.create!(title: "Yoga", date_and_time: Time.new(2024,2,5,10,00), price: "£20")
    visit gym_classes_url
    click_on "Book this gym class"

    visit bookings_url

    assert_text "Your Yoga class on 05/02/2024 at 10am has been successfully added to your Bookings"
  end

  test "Add a different class to my bookings when I have registered and logged in" do
    register
    GymClass.create!(title: "Spin", date_and_time: Time.new(2024,2,3,14,00), price: "£20")
    visit gym_classes_url
    click_on "Book this gym class"

    visit bookings_url

    assert_text "Your Spin class on 03/02/2024 at 2pm has been successfully added to your Bookings"
  end

  test "Add mutliple classes to my bookings" do
    register
    gym_class1 = GymClass.create!(title: "Spin", date_and_time: Time.new(2024,2,3,14,00), price: "£20")
    visit gym_classes_url
    id = dom_id gym_class1
    within '#' + id do
      click_on "Book this gym class"
    end
    gym_class2 = GymClass.create!(title: "Yoga", date_and_time: Time.new(2024,2,5,10,00), price: "£20")
    visit gym_classes_url
    id = dom_id gym_class2
    within '#' + id do
      click_on "Book this gym class"
    end

    visit bookings_url

    assert_text "Your Yoga class on 05/02/2024 at 10am has been successfully added to your Bookings"
    assert_text "Your Spin class on 03/02/2024 at 2pm has been successfully added to your Bookings"
  end



  # test "should Update Gym class" do
  #   visit gym_class_url(@gym_class)
  #   click_on "Edit this gym class", match: :first

  #   click_on "Update Gym class"

  #   assert_text "Gym class was successfully updated"
  #   click_on "Back"
  # end

  # test "Should destroy Gym class" do
  #   visit gym_class_url(@gym_class)
  #   click_on "Destroy this gym class", match: :first

  #   assert_text "Gym class was successfully destroyed"
  # end
end
