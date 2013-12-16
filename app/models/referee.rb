class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager
  
  validates :name, presence: true, uniqueness: true, length: {minimum: 1}
  validates :file_location, :rules_url, presence: true, length: {minimum: 1}
  validates :players_per_game, presence: true, :inclusion => 1..10
  validates_numericality_of :players_per_game, :only_integer => true
  validate :file_exists?
  
  validates_format_of :rules_url, :with => URI::regexp
  
  before_destroy :destroyAction
  
  include Uploadable 
  
  def file_exists?
    if self.file_location.nil? or !File.exist?(self.file_location)
      errors.add(:file_location, "File location must contain a file.")
    end
  end
  
  def destroyAction
    File.delete(self.file_location)
  end
  
  def referee 
    self 
  end
end
