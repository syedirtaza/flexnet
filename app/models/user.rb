class User < ApplicationRecord
  # Adds methods to set and authenticate against a BCrypt password
  has_secure_password

  # Validates presence of email
  validates :email, presence: true

  # Method to generate new tokens with error handling
  def generate_tokens
    begin
      self.update!(
        access_token: SecureRandom.urlsafe_base64,
        client: SecureRandom.urlsafe_base64,
        expiry: 1.hour.from_now.to_i
      )

      {
        "access-token": self.access_token,
        "client": self.client,
        "expiry": self.expiry,
        "uid": self.email
      }
    rescue => e
      # Log the error
      Rails.logger.error "Error generating tokens for user #{self.id}: #{e.message}"
      # Handle the error by returning a nil or a specific error message
      { error: 'Failed to generate tokens' }
    end
  end

  # Method to retrieve the tokens with error handling
  def tokens
    begin
      {
        access_token: self.access_token,
        client: self.client,
        expiry: self.expiry
      }
    rescue => e
      # Log the error
      Rails.logger.error "Error retrieving tokens for user #{self.id}: #{e.message}"
      # Handle the error by returning a nil or a specific error message
      { error: 'Failed to retrieve tokens' }
    end
  end
end
