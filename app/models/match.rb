class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true
  has_many :player_matches
  has_many :players, through: :player_matches
  
  validates :status, :manager, presence: true  

  validates_date :completion, :on_or_before => lambda { Time.now.change(:usec =>0) }, :if => :check_completed
  validates_datetime :earliest_start, :if => :check_start
  validate :check_num_players
  
  def check_num_players
    if self.players && self.manager
      if self.players.count != self.manager.referee.players_per_game
        errors.add(:manager, "Invalid number of players")
      end 
    end 
  end
  
  def check_completed
    self.status == "Completed"
  end
  
  def check_start
    if self.status == "Completed" || self.status == "Started"
      return false
    else
      return true
    end
  end
  
end