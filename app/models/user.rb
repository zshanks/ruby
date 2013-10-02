class User < ActiveRecord::Base
	# attr_reader :username, :password, :confirmation
	# attr_writer :username, :password, :confirmation
	has_secure_password
  
  validates :username, presence: true
  validates_uniqueness_of :username
  validates_length_of :username, :maximum => 25
  
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
