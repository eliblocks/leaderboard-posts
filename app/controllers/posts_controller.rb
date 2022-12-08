class PostsController < ApplicationController
  def create
    @user = User.find_or_create_by(login: params[:user][:login])
    @post = @user.posts.new(post_params)

    if @post.save
      render json: @post, include: :user, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :ip)
  end
end
