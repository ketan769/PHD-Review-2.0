class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_auth
  helper_method :logged_in?
  def current_auth 
    Auth.find_by(id: session[:user_id])  
  end
  def logged_in?
    !current_auth.nil?  
  end
end
