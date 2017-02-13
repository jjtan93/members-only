class PostsController < ApplicationController
  #before_action :logged_in_user, only: [:new, :create]
  
  def new
    @post = Post.new
  end
  
  def create
    #@post = Post.new
    @post = Post.new(post_params)
    cur_user = get_current_user
    @post.username = cur_user.username
    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_url
    else
      render 'new'
    end
  end
  
  private
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
  
    # Redirects the user back to the posts index page if he/she is not logged in
    def logged_in_user
      unless logged_in?
        flash[:danger] = "You need to be logged in to post."
        # TODO complete this <<<<<<<<<<<<<<<<<<<<<<<<<<<<
        #redirect_to posts_url
      end
    end
end
