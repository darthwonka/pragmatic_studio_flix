class Movie < ApplicationRecord
    has_many :reviews, dependent: :destroy

    RATINGS = %w(G PG PG-13 R NC-17 M X XXX)
    validates :title, :released_on, :duration,  presence: true
    validates :description, length: {minimum: 25}
    validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
    validates :image_file_name, format: { with: /\w+\.(jpg|png)\z/i, message: "must be a JPG or PNG image" }
    validates :rating, inclusion: { in: RATINGS, message: "Please use a valid RATING such as #{RATINGS}" }
    

    def self.upcoming
        where("released_on > ?", Time.now).order("released_on")
    end

    def self.released 
        where("released_on < ?", Time.now).order("released_on")
    end

    def self.adult
        where(rating: ratings('adult'))
    end

    def self.mature
        where(rating: ratings('mature'))
    end

    def self.kids 
        where(rating: ratings('kids'))
    end

    def average_stars
        reviews.average(:stars) || 0.0
    end

    def average_stars_as_percent
        self.average_stars/5.0 * 100
    end

    def flop?
        total_gross < 350000000
    end

    private 
        def ratings(name)
            case name
            when 'mature' 
                ['R','NC-17']
            when 'adult'
                ['M','X','XXX']
            when 'kids'
                ['G','PG','PG-13']
            end
        end
        

end
