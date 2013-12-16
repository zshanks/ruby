class RefereesController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new,:create,:edit,:update,:destroy]
  before_action :ensure_owner, only: [:update,:destroy,:edit]
  before_action :ensure_contest_creator, only: [:edit , :update , :create , :new]
  before_action :retrieve_referee, only: [:show, :edit, :destroy, :update]
  
	def new
		@referee = current_user.referees.build
	end	

	def create
    @referee = current_user.referees.build(permitted_params)
    if @referee.save then
      flash[:success] = "Referee successfully created"
      redirect_to @referee
    else
      render 'new'
    end
  end
    
  def show
    @referee = Referee.find(params[:id])
  end
		
  def index
    @referee = Referee.all
  end
		
	def edit
	end
    
  def update
    @referee = Referee.find(params[:id])
    if @referee.update(permitted_params) then
      flash[:success] = "Successfully made updates to referee"
      redirect_to @referee
    else
      flash.now[:danger] = "Unable to update referee"
      render 'edit'
		end
  end
    
  def destroy
    @referee = Referee.find(params[:id])
    flash[:success] = "Referee has been destroyed!"
    @referee.destroy
    redirect_to "/referees"
  end
	
  private
    def permitted_params
      params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
    end
    
    def ensure_user_logged_in
      redirect_to login_path, flash: { :warning => "Unable, please log in!" } unless logged_in? 
    end
    
    def ensure_owner
      @referee = retrieve_referee
      (flash[:danger] = "You are not the correct user" and redirect_to root_path) unless owner?(@referee)
    end
    
    def ensure_contest_creator
      (flash[:danger] = "You do not have the appropriate permissions" and redirect_to root_path) unless current_user.contest_creator?
    end
    
    def retrieve_referee
      @referee = Referee.find(params[:id])
    end
end
