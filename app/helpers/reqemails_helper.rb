module ReqemailsHelper
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def add_new_email(email_token)
  	email_token = email_token.downcase
  	if !email_exists?(email_token)
	  	Reqemail.create(email_digest: Reqemail.digest(email_token))
  	end
  end

  def email_exists? (email_token)
	if email_token == nil || email_token == "" 
		return false
	end
	email_token = email_token.downcase
	Reqemail.all.each do |re|
		if re.authenticated? (email_token)
			return true
		end
	end
	return false
  end

  def email_valid? (email_token)
  	
  	if email_token == nil || email_token == "" || email_token.length<15 || email_token[email_token.length-13, email_token.length] != "@stanford.edu" || !(email_token =~ VALID_EMAIL_REGEX)
		return false
	else
		return true
	end
  end

end
