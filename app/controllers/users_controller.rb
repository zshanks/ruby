class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_admin_user, only: [:edit, :update]
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
    
  def update
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
    
    def ensure_correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
    
    def ensure_admin_user
      redirect_to users_path unless current_user.admin?
    end
end