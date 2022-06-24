class FavoritesController < ApplicationController
    before_action :require_signin
    before_action :set_movie
   
    def create
        @movie.favorites.create!(user: current_user)
        redirect_to @movie
    end

    def destroy
        favorite = current_user.favorites.find_by(movie_id: @movie.id)

        if favorite.destroy
            redirect_to @movie
        end
    end

    private

    def set_movie
        @movie = Movie.find_by!(slug: params[:movie_id])
    end

end

