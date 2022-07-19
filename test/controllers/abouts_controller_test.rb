require "test_helper"

class AboutsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get abouts_new_url
    assert_response :success
  end

  test "should get index" do
    get abouts_index_url
    assert_response :success
  end
end
