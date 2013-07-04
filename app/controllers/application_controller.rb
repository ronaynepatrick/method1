class ApplicationController < ActionController::Base
  protect_from_forgery

  #filter_parameter_logging :password, :password_confirmation # there are underscores  

  helper_method :current_user_session, :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      logger.debug "ApplicationController::require_user"
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      logger.debug "ApplicationController::require_no_user"
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        #redirect_to home_index_path
        return false
      end
    end

# -->> DEFINED AUTHORISATIONS
    
    def require_admin
      if current_user
        if @current_user.permission == 2
          return true
        end
      end
      flash[:notice] = "You must be the admin to access this page"
      redirect_to :home_page
      return false
    end

    def require_cont
      if current_user
        if @current_user.permission > 0
          return true
        end
      end
      flash[:notice] = "You must be a contributor to access this page"
      redirect_to :home_page
      return false
    end

    def require_creator
      if current_user
        
      end
    end
# --<< END

    def store_location
      #puts request.inspect
      #session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

# -->> other apis
    # def load_content
    #   passages = Passage.where(page_id: session[:page_id])
    #   videos = Video.where(page_id: session[:page_id])
    #   docs = Document.where(page_id: session[:page_id])
    #   pics = Pic.where(page_id: session[:page_id])
    #   @content = passages+videos+docs+pics
    #   return @content
    # end
end 
