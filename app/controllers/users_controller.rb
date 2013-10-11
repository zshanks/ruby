class UsersController < ApplicationController
	def new
		@user = User.new
	end
  
  def create
		@user = User.new(permitted_params)
    if @user.save then
			flash[:success] = "Welcome to the site: #{@user.username}"
			redirect_to @user #type of response that the server can give to the browser.
		else
			render 'new'
		end
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
end