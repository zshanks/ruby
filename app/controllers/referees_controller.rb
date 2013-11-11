class RefereesController < ApplicationController
	def new
		@referee = current_user.referees.build
	end	

	def create
		@referee = current_user.referees.build(acceptable_params)
	end
	
	def acceptable_params
		params.require(:referee).permit(:name, 
						:rules_url, 
						:players_per_game, 
						:upload)
	end
end
