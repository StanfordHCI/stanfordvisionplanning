class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:index, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @ideas = @user.ideas.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @code_token = params['regcode'] 
    regcode = regcode_for(@code_token)
    if regcode == nil
      flash[:danger] = "A valid registration code is needed to sign up, request a code here."
      redirect_to '/regcodes/new'  and return
    else
      @user = User.new
    end

  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def create
    p params
    code_token = user_params['code_token'].to_s
    @user = User.new(user_params.slice('name', 'email', 'password', 'password_confirmation'))
    regcode = regcode_for(code_token)

    if regcode == nil 
      flash[:danger] = "A valid registration code is needed to sign up." + code_token
      redirect_to root_url
    elsif @user.save
        regcode.used = true
        regcode.save
        log_in @user
        flash[:success] = "Welcome!"
        redirect_to root_url 
    else
      @code_token = code_token
      render 'new'
    end
    
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params.slice('name', 'email', 'password', 'password_confirmation'))
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :code_token)
    end
 
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
