require "test_helper"

class Api::ParkingLotsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_parking_lots_create_url
    assert_response :success
  end

  test "should get show" do
    get api_parking_lots_show_url
    assert_response :success
  end
end
