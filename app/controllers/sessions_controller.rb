class SessionsController < ApplicationController
  #before_action :ensure_user_logged_in, only: [:edit, :update]
  
  def new
  end
	
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
    cookies.delete(:user_id)
    flash[:info] = "You have successfully logged out"
    redirect_to root_path
	end
end
