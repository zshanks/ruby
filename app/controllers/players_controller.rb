class PlayersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :update, :destroy, :edit]
  before_action :ensure_owner, only: [:update , :destroy, :edit]
  before_action :retrieve_player, only:  [:show, :edit, :destroy, :update]

	def new
    contest = Contest.find(params[:contest_id])
    @player = contest.players.build
	end
  
  def create
		contest = Contest.find(params[:contest_id])
    @player = contest.players.build(permitted_params)
    @player.user = current_user
    if @player.save then
      flash[:success] = "Player successfully created!"
      redirect_to @player
    else
      flash[:danger] = "No player for you!"
      render :new
		end
  end
    
  def show
  end
		
  def index
    @players =Player.all
  end
		
	def edit
	end
    
  def update
    if @player.update(permitted_params)
      flash[:success] = "Player successfully updated"
      redirect_to @player
    else
      flash[:danger] = "Player can't be updated"
      render 'edit'
    end
  end
    
  def destroy
    flash[:success] = "Your precious player was DESTROYED!"
    @player.destroy
    redirect_to contest_players_path(@player.contest)
  end
	
  private 
    def ensure_user_logged_in
      redirect_to login_path, flash: { :warning => "Unable, please log in!" } unless logged_in? 
    end
    
    def ensure_owner
      @player = retrieve_player
      (flash[:danger] = "You are not the correct user" and redirect_to root_path) unless owner?(@player)
    end
    
    def retrieve_player
      @player = Player.find(params[:id])
    end
		
    def permitted_params
      params.require(:player).permit(:upload, :description, :name, :downloadable, :playable)
    end
end
