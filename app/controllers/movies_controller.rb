class MoviesController < ApplicationController
    def index
        @movies = Movie.released
    end
    def show
        @movie = Movie.find(params[:id])
    end
    def edit
        @movie = Movie.find(params[:id])
    end
    def update
        @movie = Movie.find(params[:id])
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
        @movie = Movie.find(params[:id])
        @movie.destroy 
        redirect_to movies_url, alert: "Movie deleted successfully"
    end

    private 
    
        def required_params
            params.require(:movie).permit(:title,:description,:rating, :released_on, :total_gross, :director, :duration, :image_file_name)
        end

        def set_movie
            @movie = Movie.find_by(id: params[:movie_id])
        end
end
