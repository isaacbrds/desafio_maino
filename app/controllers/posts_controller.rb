class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :destroy, :update]
  before_action :authenticate_user!, except: [:show]
  def index
    @posts = Post.all
  end

  def new  
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user
    if @post.save 
      redirect_to posts_path, notice: 'post was successfully created!'
    else
      render :new
    end
  end

  def edit; end

  def update 
    if @post.update(post_params)
      redirect_to posts_path, notice: 'post was successfully updated!'
    else
      render :edit 
    end
  end

  def show  
    @post = Post.includes(:user).find(params[:id])
  end

  def destroy 
    @post.destroy
    redirect_to posts_path, notice: 'post was successfully detroyed!'
  end
  private 

  def post_params 
    params.require(:post).permit(:title, :content, :user_id)
  end
  
  def set_post 
    @post = Post.find(params[:id])
  end
end
