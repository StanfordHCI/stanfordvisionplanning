class RegcodesController < ApplicationController
  def new
  	@regcode = Regcode.new
  end
  def create
    email = params['email']
    email = email.downcase
    if !email_exists? (email)
    	code_token = Regcode.new_code
    	@regcode = Regcode.new(code_digest: Regcode.digest(code_token) , used: false)

      if @regcode.save
        UserMailer.receive_regcode(email, code_token).deliver_now
        add_new_email(email)
        flash[:success] = "Success! A one-time registration link was sent to "+email
        redirect_to root_path
      else
        flash[:danger] = "Unable to generate new code please contact admin" 
        render 'new'  
      end
    else
        flash[:danger] = "Email has already received registration code." 
        render 'new'  
    end
    
  end
end
