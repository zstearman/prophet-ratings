module TeamSeasonsHelper
  def rank(label, record)
    TeamSeason.where( label + " > ?", record).count + 1
  end
end
