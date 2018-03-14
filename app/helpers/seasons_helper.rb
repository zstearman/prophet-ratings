module SeasonsHelper
  
  def current_season 
    @current_season ||= Season.find_by(active: true).first
  end
end
