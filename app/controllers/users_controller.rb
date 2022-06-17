class UsersController < ApplicationController

    def index 
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def edit 
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(required_params)
        if @user.save
            redirect_to @user, success: "Thanks for Signing Up!"
        else
            render :new, alert: "Problem saving your information"
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(required_params)
            redirect_to @user, notice: "User updated successfully"
        else 
            render :edit, notice: "User update Failed"
        end
    end
    
    private

        def required_params
            params.require(:user).permit(:name,:email,:password, :password_confirmation)
        end




end
