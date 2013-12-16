class ContestsController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :update, :destroy, :edit]
  before_action :ensure_contest_creator, only: [:edit, :update, :create, :new, :destroy]
  before_action :ensure_owner, only: [:update, :destroy, :edit]
  before_action :retrieve_contest, only: [:show, :edit, :update, :destroy]
  
  def new
    @contest = current_user.contests.build
  end
  
  def index
    @contests = Contest.all
  end
  
  def show
    @contest = Contest.find(params[:id])
  end
  
  def edit
  end
  
  def destroy
    @contest = Contest.find(params[:id])
    flash[:success] = "Contest has been destroyed! MUAHAHAHA!!!"
    @contest.destroy
    redirect_to "/contests"
  end
  
  def create
    @contest = current_user.contests.build(permitted_params)
    if@contest.save
      flash[:success] = "Contest has been created! YIPPIE!!!"
      redirect_to @contest
    else
      flash[:danger] = "Can't create contest.. Sad day for all"
      render :new
    end
  end
  
  def update
    @contest = Contest.find(params[:id])
    if @contest.update(permitted_params)
      flash[:success] = "Contest has been updated!"      
      redirect_to @contest
    else
      flash.now[:danger] = "Cant update contest."
      render 'edit'
    end
  end
  
  
  private
    def permitted_params
      params.require(:contest).permit(:deadline, :start, :description, :name, :contest_type, :referee_id)
    end
  
    def ensure_owner
      @contest = retrieve_contest
      (flash[:danger] = "You are not the correct user" and redirect_to root_path) unless owner?(@contest)
    end
    
    def ensure_contest_creator
      (flash[:danger] = "You do not have the appropriate permissions" and redirect_to root_path) unless current_user.contest_creator?
    end
    
    def retrieve_contest
      @contest = Contest.find(params[:id])
    end
  end
