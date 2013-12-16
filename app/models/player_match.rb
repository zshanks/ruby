class PlayerMatch < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  
  validates :player, :match, presence: true
end
