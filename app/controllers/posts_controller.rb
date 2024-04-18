class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :destroy, :update]
  before_action :authenticate_user!, except: [:show]
  def index
    @posts = Post.all
  end

  def new  
    @post = Post.new
    @post.tags.build
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

  def import
    @arquivo = params[:arquivo]
    response = check_extension(@arquivo)
    if response
      redirect_to posts_path, notice: t('post was successfully imported!')
    else
      redirect_to posts_path, notice: t('post was not successfully imported!')
    end
  end
  private 

  def post_params 
    params.require(:post).permit(:title, :content, :user_id, tags_attributes: %i[id title _destroy])
  end
  
  def set_post 
    @post = Post.find(params[:id])
  end
  
  def check_extension(arquivo)
    extension = ['.txt']
    if extension.include? File.extname(arquivo)
      File.open(arquivo) do |f|
        f.each_with_index do |linha, i|
          coluna = linha.split(',')
          title = "#{coluna[0]} - #{i}"
          user_id = coluna[1]
          HardWorker.perform_async(title, user_id)
        end
      end
      return response
    end
    false
  end
end
