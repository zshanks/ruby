class SessionsController < ApplicationController
  before_action :ensure_user_logged_in, only: [:edit, :update]
	
	def create
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
      cookies.signed[:user_id] = @user.id
			flash[:success] = "#{@user.username} logged on."
			redirect_to @user
		else
			flash.now[:danger] = 'Invalid username or password'
			render 'new'
		end
	end

	def destroy
	end
  
  def new
		@user = User.new
	end
    
  def show
    @user = User.find(params[:id])
  end
		
  def index
    @users = User.all
  end
    
  def edit
    @user = User.find(params[:id])
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update(permitted_params) then
			redirect_to @user
		else
      render 'edit'
		end
  end
    
  def destroy
		@user = User.find(params[:id]).destroy
    redirect_to users_path
  end  
    
  private 
    def permitted_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end
  
    def ensure_user_logged_in
      redirect_to root_path unless logged_in?
    end
end
