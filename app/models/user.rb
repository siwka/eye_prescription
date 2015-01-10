class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end


class User < ActiveRecord::Base
  has_many :prescriptions

  attr_accessor :remember_token

	before_save   :downcase_email
  
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    email: true,
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 8,
                                 message: "require minimum 8 characters" }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?    
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

private

	def downcase_email
	  email.downcase!
	end

end
