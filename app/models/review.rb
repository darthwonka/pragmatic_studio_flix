class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :name, presence: true
  validates :comment, length: {minimum: 25}
  validates :stars, numericality: { greater_than_or_equal_to: 0 , less_than_or_equal_to: 5 }

  STARS = [1,2,3,4,5]

  def stars_as_percent
    (stars / 5.0) * 100.0
  end
 
end
