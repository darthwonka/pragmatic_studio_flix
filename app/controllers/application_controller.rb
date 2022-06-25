class ApplicationController < ActionController::Base


    private 

    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def current_user?(user)
        current_user == user && user 
    end
    helper_method :current_user?

    def current_user_is_admin?
        current_user && current_user.admin?
    end
    helper_method :current_user_is_admin?

    def require_signin
        unless current_user
            session[:intended_url] = request.url
            redirect_to new_session_url, alert: "Please sign in first!"
        end
    end

    def require_correct_user
        @user = User.find_by(username: params[:id])
        unless current_user?(@user) || current_user_is_admin?
            redirect_to movies_url, alert: "**Unauthorized**"
        end
    end

    def require_admin
        unless current_user_is_admin?
            session[:intended_url] = request.url
            redirect_to new_session_url, alert: "This page requires administrator access"
        end
    end


end
