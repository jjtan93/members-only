class User < ApplicationRecord
  attr_accessor :remember_token
  
  before_create :create_remember_digest
  
  has_secure_password
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Encrypts the given string
  def User.encrypt(string)
    Digest::SHA1.hexdigest(string.to_s)
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.encrypt(remember_token))
  end
  
  private
    # Creates and assigns the remember token and digest.
    def create_remember_digest
      self.remember_token  = User.new_token
      self.remember_digest = User.encrypt(remember_token)
    end
    
end
