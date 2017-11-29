class User < ApplicationRecord
    before_save { self.email = email.downcase }
    before_save { self.state = state.upcase }
    validates :name,  presence: true, length: { maximum: 50 }
    validates :street,  presence: true, length: { maximum: 51 }
    validates :city,  presence: true, length: { maximum: 50 }
    validates :state,  presence: true, length: { maximum: 2 }
    validates :zip,  presence: true, length: { maximum: 5 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
