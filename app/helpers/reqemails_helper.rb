module ReqemailsHelper
  def add_new_email(email_token)
  	email_token = email_token.downcase
  	if !email_exists?(email_token)
	  	Reqemail.create(email_digest: Reqemail.digest(email_token))
  	end
  end

  def email_exists? (email_token)
	if email_token == nil || email_token == "" # || email_token[email_token.len-13, email_token.len] != "@stanford.edu"
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
end
