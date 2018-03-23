module TeamSeasonsHelper
  def rank(label, record)
    TeamSeason.where( label + " > ?", record).count + 1
  end

  def inverse_rank(label, record)
    TeamSeason.where( label + " < ?", record).count + 1
  end
end
