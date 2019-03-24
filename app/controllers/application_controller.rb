class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #set a cookie to CSRF protection
  after_action :set_csrf_cookie

  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  private
    def current_user
      return User.first if DUMMY_LOG_ON 
      @user ||= session['session_id'] && User.find_by_session_token(session['session_id'])
    end

    def authenticate_user!
      redirect_to session_new_path if current_user.blank? && !DUMMY_LOG_ON
    end

    #verified request with X-XSRF-TOKEN
    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end
end
