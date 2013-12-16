class Player < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  has_many :matches, through: :player_matches
	has_many :player_matches
	
	validates :user, :contest, presence: true
  validates :description, :name, presence: true, length: {minimum: 1}
	validates :name, presence: true, uniqueness: {scope: :contest}
	#validates :file_location, presence: true
  validate :existing_file?
	
  before_destroy :destroyAction
  
	include Uploadable
  
  def existing_file?
    if self.file_location.nil? or !File.exist?(self.file_location)
      errors.add(:file_location, "File location must contain a file.")
    end
  end
  
  def destroyAction
    File.delete(self.file_location)
  end
end
