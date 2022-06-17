module ReviewsHelper
  def review_stars_as_percent(review)
    (review.stars / 5.0) * 100
  end
end
