module FavoritesHelper

    def fav_or_unfav_button(movie,favorite)

        if favorite 
           button_to "♡ unfavorite", movie_favorites_path(movie), method: :delete 
        else 
          button_to "♥️ Favorite", movie_favorites_path(movie) 
        end 
    end

end
