require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get edits" do
    get accounts_edits_url
    assert_response :success
  end

  test "should get update" do
    get accounts_update_url
    assert_response :success
  end

  test "should get destory" do
    get accounts_destory_url
    assert_response :success
  end
end
