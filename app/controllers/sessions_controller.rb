class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if(user && user.authenticate(params[:session][:password]))
      remember_user(user)
      flash[:success] = "You have logged in!"
      redirect_to posts_url
    else
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to posts_url
  end
end
