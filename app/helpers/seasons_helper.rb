module SeasonsHelper
  
  def current_season 
    @current_season ||= Season.find_by(current: true)
  end
end
