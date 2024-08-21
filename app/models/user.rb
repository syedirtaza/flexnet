class User < ApplicationRecord
    has_secure_password
  
    # Method to generate new tokens
    def generate_tokens
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
    end
  
    # Method to retrieve the tokens
    def tokens
      {
        access_token: self.access_token,
        client: self.client,
        expiry: self.expiry
      }
    end
  end
  