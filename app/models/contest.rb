class Contest < ActiveRecord::Base
	belongs_to :user
	belongs_to :referee
	has_many :players
	has_many :matches
	
	validates :user, :referee, :contest_type, :start, :deadline, :description, presence: true
	validates :name, presence: true, uniqueness: true
	#validates_datetime :start, :on_or_after => :now
	#validates_datetime :start, :on_or_before => lambda { |record| record.start }

	#include Uploadable
end
