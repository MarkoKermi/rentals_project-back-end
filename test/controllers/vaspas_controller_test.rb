require "test_helper"

class VaspasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vaspa = vaspas(:one)
  end

  test "should get index" do
    get vaspas_url, as: :json
    assert_response :success
  end

  test "should create vaspa" do
    assert_difference("Vaspa.count") do
      post vaspas_url, params: { vaspa: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show vaspa" do
    get vaspa_url(@vaspa), as: :json
    assert_response :success
  end

  test "should update vaspa" do
    patch vaspa_url(@vaspa), params: { vaspa: {  } }, as: :json
    assert_response :success
  end

  test "should destroy vaspa" do
    assert_difference("Vaspa.count", -1) do
      delete vaspa_url(@vaspa), as: :json
    end

    assert_response :no_content
  end
end
