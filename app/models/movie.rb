class Movie < ApplicationRecord

    before_save :set_slug

    has_many :reviews, -> {order(created_at: :desc) }, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :fans, through: :favorites, source: :user
    has_many :characterizations, dependent: :destroy
    has_many :genres, through: :characterizations

    RATINGS = %w(G PG PG-13 R NC-17 M X XXX)
    validates :released_on, :duration,  presence: true
    validates :title, presence: true, uniqueness: true

    validates :description, length: {minimum: 25}
    validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
    validates :image_file_name, format: { with: /\w+\.(jpg|png)\z/i, message: "must be a JPG or PNG image" }
    validates :rating, inclusion: { in: RATINGS, message: "Please use a valid RATING such as #{RATINGS}" }
    
    scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on") }
    scope :released, -> { where("released_on < ?", Time.now).order("released_on") }
    scope :recent, -> max=3 { released.limit(max) }
    scope :flop, -> { released.where("total_gross < 350000000")  }
    scope :blockbuster, -> { released.where("total_gross >= 800000000")  }
    scope :hits, -> { released.where("total_gross >= 350000000")  }
    

    def flop?
        total_gross < 350000000
    end

    def average_stars
        reviews.average(:stars) || 0.0
    end

    def average_stars_as_percent
        self.average_stars/5.0 * 100
    end


    def to_param
        slug
    end


    private 

        def set_slug 
            self.slug = title.parameterize 
        end
        

end
