require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(password: "password123")
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user without password" do
    user = User.new(email: "user@example.com")
    assert_not user.save, "Saved the user without a password"
  end

  test "should save user with valid email and password" do
    user = User.new(email: "user@example.com", password: "password123")
    assert user.save, "Failed to save the user with valid email and password"
  end

  # Test Token Generation Method
  test "should generate tokens" do
    user = User.create(email: "user@example.com", password: "password123")
    tokens = user.generate_tokens
    assert tokens[:'access-token'].present?, "Access token is not generated"
    assert tokens[:client].present?, "Client token is not generated"
    assert tokens[:expiry].present?, "Expiry time is not generated"
  end
end
