class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :matches, as: :manager
  
  def upload=(uploaded_io)
    if uploaded_io.nil?
      # problem--deal with later
    else
      time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
      file_location = Rails.root.join('code', 'referees', time_no_spaces).to_s
      self.file_location = 'the final location on the server'
    end
  end
end
