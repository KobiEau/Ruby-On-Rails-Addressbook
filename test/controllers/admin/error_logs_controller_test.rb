require "test_helper"

class Admin::ErrorLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_error_logs_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_error_logs_show_url
    assert_response :success
  end
end
