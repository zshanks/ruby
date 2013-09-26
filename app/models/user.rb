class User < ActiveRecord::Base
	# attr_reader :username, :password, :confirmation
	# attr_writer :username, :password, :confirmation
	has_secure_password
  
  validates :username, presence: true
  
  validates :email, presence: true
  validates_format_of :email, :with => /^(+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
