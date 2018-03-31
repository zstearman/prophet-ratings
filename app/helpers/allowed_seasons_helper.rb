module AllowedSeasonsHelper
  def allowed_rank(label, record)
    AllowedSeason.where( label + " > ?", record).count + 1
  end

  def allowed_inverse_rank(label, record)
    AllowedSeason.where( label + " < ?", record).count + 1
  end
end
