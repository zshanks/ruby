class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true
  has_many :player_matches
  has_many :players, through: :player_matches
  
  validates :status, :completion, :manager, :earliest_start, presence: true
  
  validates_datetime :earliest_start, :on_or_after => :now
  validates_datetime :completion, :on_or_before => lambda { |record| record.earliest_start }  
end
