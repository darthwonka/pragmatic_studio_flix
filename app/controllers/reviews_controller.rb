class ReviewsController < ApplicationController
    before_action :set_movie

    def index
        @reviews = @movie.reviews
    end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(required_params)
        if @review.save
            redirect_to movie_reviews_url, success: "Thanks for your Review!"
        else
            render :new, alert: "There were errors in your review!"
        end
    end

    def edit
        @review = @movie.reviews.find_by( id: params[:id] )
    end

    def update
        @review = @movie.reviews.find_by( id: params[:id] )
        if @review.update(required_params)
            redirect_to @movie, notice: "Review updated successfully"
        else 
            render :edit
        end
    end

    def destroy
        @review = @movie.reviews.find_by( id: params[:id])
        @review.destroy 
        redirect_to movie_reviews_url, alert: "Review deleted successfully"
    end

    private
        def required_params
            params.require(:review).permit(:name,:stars,:comment)
        end
        
        def set_movie
            @movie = Movie.find_by(id: params[:movie_id])
        end

end

