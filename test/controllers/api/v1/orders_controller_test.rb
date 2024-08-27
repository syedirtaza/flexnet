require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get order details with valid tokens" do
    user = User.create(email: "user@example.com", password: "password123")
    tokens = user.generate_tokens

    get '/api/v1/orders/1', headers: {
      "access-token": tokens[:'access-token'],
      "client": tokens[:client],
      "expiry": tokens[:expiry].to_s,
      "uid": user.email
    }, as: :json

    assert_response :success
  end

  test "should not get order details with invalid tokens" do
    get '/api/v1/orders/1', headers: {
      "access-token": "invalid_token",
      "client": "invalid_client",
      "expiry": "0",
      "uid": "user@example.com"
    }, as: :json

    assert_response :unauthorized
  end
end
