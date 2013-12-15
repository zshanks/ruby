class Player < ActiveRecord::Base
	belongs_to :user
	belongs_to :referee
	has_many :player_matches
	has_many :matches
	
	validates :user, :contest, :contest_type, :description, presence: true
	validates :name, presence: true, uniqueness: {scope: :contest}
	#validates :file_location, presence: true
	#validate :check_location
	
	#include Uploadable
end
