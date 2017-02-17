module SessionsHelper
  
  # Logs in and remembers the given user in a persistent session.
  def remember_user(user)
    user.remember
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    #self.current_user = user
    @current_user = user
  end
  
  def current_user=(user)
		@current_user = user
	end
  
  # Returns the current user, if any, whose remember_token is stored as a cookie
  def get_current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_digest: remember_token )
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete :user_id
    cookies.delete :remember_token
  end
  
  def logged_in?
    get_current_user
    return !@current_user.nil?
  end
end
