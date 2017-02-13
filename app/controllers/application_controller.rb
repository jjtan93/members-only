class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Logs in the given user
  #def log_in(user)
  #  params[session][user_id] = user.id
  #end
  
  # Logs in and remembers the given user in a persistent session.
  def remember_user(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns the current user, if any, whose remember_token is stored as a cookie
  def get_current_user
    @current_user ||= User.find_by(remember_digest: User.encrypt(cookies.permanent[:remember_token]) )
    return nil if @current_user == nil
    #if (user_id = session[:user_id])
    #  @current_user ||= User.find_by(id: user_id)
    #else
    #  return nil
  end
  
  def sign_out
    @current_user = nil
    cookies.permanent.delete :user.id
    cookies.permanent.delete :remember_token
  end
  
  def logged_in?
    return false if(get_current_user == nil)
    return true
  end
end
