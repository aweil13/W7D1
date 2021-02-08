class ApplicationController < ActionController::Base
        helper_method :current_user, :logged_in?

        def login!(user)
            session[:session_token] = user.reset_session_token!
        end
                    
        def current_user
            @current_user ||= User.find_by(session_token: session[:session_token])
        end 

        def logged_in?
            !!current_user
        end

        def login_user!(user)
            if user
                login!(user)
                redirect_to cats_url
            else
                user = User.new
                render :new
            end 
        end 

        def require_logged_in
            redirect_to new_session_url unless logged_in?
        end 

        def require_logged_out
            redirect_to cats_url if logged_in?
        end 

end
