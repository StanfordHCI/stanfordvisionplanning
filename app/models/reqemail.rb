class Reqemail < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email_digest,  presence: true, uniqueness: true
	def Reqemail.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end
  	# Returns true if the given token matches the digest.
  	def authenticated?(email_token)
  		return false if email_digest.nil?
    	BCrypt::Password.new(email_digest).is_password?(email_token)
  	end


end
