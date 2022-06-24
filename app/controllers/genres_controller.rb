class GenresController < ApplicationController
    before_action :require_admin, only: [:new, :edit, :update, :create, :destroy]
    before_action :set_genre


    def index
        @genres = Genre.all.order(:name)
    end

    def show
        @movies = @genre.movies
    end

    def new
        @genre = Genre.new
    end

    def create
        @genre = Genre.new(required_params)
        if @genre.save
            redirect_to genres_url, notice: "#{@genre.name} genre successfully added"
        end
    end

    def edit 
    end

    def update
        if @genre.update(required_params)
            redirect_to genres_url, notice: "Successfully updated #{@genre.name}"
        else 
            redirect_to @genre, alert: 'Failed to Update!  Check Form'
        end
    end

    def destroy
        if @genre.destroy
            redirect_to genres_url, alert: "Destoyed the #{@genre.name} Genre.  Good Riddence!"
        end
    end

    private
        def required_params 
            params.require(:genre).permit([:name]) 
        end

        def set_genre
            @genre = Genre.find_by(slug: params[:id])
        end

end
