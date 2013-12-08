class User < ActiveRecord::Base
  has_many :referees
  has_many :players
  has_many :contests
	has_secure_password
  
  validates :username, presence: true
  validates_uniqueness_of :username
  validates_length_of :username, :maximum => 25
  
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	
end
