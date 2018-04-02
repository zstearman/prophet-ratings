module ProphetRatingsHelper
  def prophet_rank(label, record)
    ProphetRating.where( label + " > ?", record).count + 1
  end

  def prophet_inverse_rank(label, record)
    ProphetRating.where( label + " < ?", record).count + 1
  end
end