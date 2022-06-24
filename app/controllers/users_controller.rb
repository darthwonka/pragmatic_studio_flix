class UsersController < ApplicationController
    before_action :set_user
    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update]
    before_action :require_admin, only: [:edit, :update, :destroy]

    def index 
        @users = User.not_admin
    end

    def show
        @reviews = @user.reviews
        @favorites = @user.favorite_movies
    end

    def edit 
    end

    def new
        @user = User.new
    end

    def edit 
    end

    def create
        @user = User.new(required_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user, success: "Thanks for Signing Up!"
        else
            render :new, alert: "Problem saving your information"
        end
    end

    def update
        if @user.update(required_params)
            redirect_to @user, notice: "User updated successfully"
        else 
            render :edit, notice: "User update Failed"
        end
    end

    def destroy
        @user.destroy 
        session[:user_id] = nil
        redirect_to users_url, alert: "User deleted successfully"
    end


    private

        def required_params
            params.require(:user).permit(:username, :name, :email, :aboutme, :password, :password_confirmation)
        end

        def set_user
            @user = User.find_by(username: params[:id])
        end

end
