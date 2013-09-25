class User < ActiveRecord::Base
	# attr_reader :username, :password, :confirmation
	# attr_writer :username, :password, :confirmation
	has_secure_password
	
	validates :username, presence: true
end
