class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if(user && user.authenticate(params[:session][:password]))
      remember_user(user)
      #set_current_user(user)
      # TODO redirect <<<<<<<<<<<<<<<<<<<<<<<<<<<
    else
      render 'new'
    end
  end
  
  def delete
    sign_out
  end
end
