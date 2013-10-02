class UsersController < ApplicationController
  def new
		@user = User.new
  end

  def create
    #@user = User.new(:username => params[:username],:password => params[:password])
    #render 'new'
    
		permitted_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
		@user = User.new(permitted_params)
		if @user.save then
			redirect_to @user #type of response that the server can give to the browser.
		else
			render 'new'
		end
  end
	
	def index
		@users = User.all
	end

	def show
		@user - User.find(params[:id])
	end
	
	def edit
		@user - User.find(params[:id])
	end	
end
