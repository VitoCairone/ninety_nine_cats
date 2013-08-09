class ApplicationController < ActionController::Base
  protect_from_forgery

  def ensure_logged_in
    unless logged_in?
      puts "@@@@@@ params = #{params}"
      puts "@@@@@@ session = #{session}"
      redirect_to new_sessions_url
    end
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end
end
