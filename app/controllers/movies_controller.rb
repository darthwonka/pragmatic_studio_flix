class MoviesController < ApplicationController


    before_action :require_admin, only: [:new, :edit, :update, :create, :destroy]
    before_action :set_movie

    def index
         @movies = Movie.send(movie_filter)
    end

    def show
        @fans = @movie.fans
        @genres = @movie.genres.order(:name)
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end

    def edit
    end

    def update
        if @movie.update(required_params)
            redirect_to @movie, notice: "Movie updated successfully"
        else 
            render :edit
        end
    end
    def new
        @movie = Movie.new()
    end

    def create 
        @movie = Movie.new(required_params)
        if @movie.save
            redirect_to @movie, notice: "Movie created successfully"
        else 
            render :new
        end
    end

    def destroy
        @movie.destroy 
        redirect_to movies_url, alert: "Movie deleted successfully"
    end

    private 
    
        def required_params
            params.require(:movie).permit(:title,:description,:rating, :released_on, :total_gross, :director, :duration, :image_file_name, 
                                            genre_ids: [] )
        end


        def set_movie
            @movie = Movie.find_by(slug: params[:id])
        end

        def movie_filter
            if params[:filter].in? %w(upcoming recent hits flops)
                params[:filter]
            else
                :released
            end
        end
end
