module MoviesHelper

    def date_and_time(movie)
        movie.release_date.strftime('%Y')
    end

    def total_gross(movie)
        if movie.flop?
            "Flop!"
        else 
            number_to_currency(movie.total_gross, precision: 0)
        end
    end

    def average_stars(movie)
        if movie.average_stars.zero?
            content_tag(:strong, "No reviews")
        else
            pluralize(number_with_precision(movie.average_stars,precision: 1),"star")
        end
    end

end
