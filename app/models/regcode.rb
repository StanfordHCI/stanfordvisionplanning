class Regcode < ApplicationRecord
	validates :code_digest,  presence: true, uniqueness: true
	def Regcode.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end
  	# Returns true if the given token matches the digest.
  	def authenticated?(code_token)
  		return false if code_digest.nil?
    	BCrypt::Password.new(code_digest).is_password?(code_token)
  	end

  	# Returns a random token.
	def Regcode.new_code
		SecureRandom.urlsafe_base64
	end
end
