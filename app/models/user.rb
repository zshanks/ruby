class User < ActiveRecord::Base
  has_many :referees
  has_many :players
  has_many :contests
  before_create :create_remember_token
	has_secure_password
  
  validates :username, presence: true
  validates_uniqueness_of :username
  validates_length_of :username, :maximum => 25
  
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
