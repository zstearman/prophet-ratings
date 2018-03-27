class Player < ApplicationRecord
  has_many :player_games
  belongs_to :team
  
  def formatted_height
    feet = (height / 12).floor
    inches = height % 12
    @formatted_height = feet.to_s + "' " + inches.to_s + '"'
  end
end
