module MockDevise
  def authenticate_user!
    true
  end
  
  def current_user
    session[:current_user]
  end
  
  def current_user=(user)
    session[:current_user] = user
  end
  
  def user_session
    session[:user_session] ||= {}
  end
end