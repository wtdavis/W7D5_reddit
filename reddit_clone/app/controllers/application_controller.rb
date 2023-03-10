class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        @user = User.find_by(session_token: session[:session_token!])
    end

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def ensure_logged_out
        redirect_to user_url if logged_in?
    end


    def logged_in?
        !!current_user
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout!
        session[:session_token] = nil
        self.reset_session_token!
    end



end
