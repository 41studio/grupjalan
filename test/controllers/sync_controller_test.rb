require 'test_helper'

class SyncControllerTest < ActionController::TestCase
  test "should get get_provinces" do
    get :get_provinces
    assert_response :success
  end

  test "should get get_cities" do
    get :get_cities
    assert_response :success
  end

end
