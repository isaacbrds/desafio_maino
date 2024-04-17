class CommentsController < ApplicationController
    before_action :set_post

  def create
    if current_user
      @post.comments.create(comment_parms.to_h.merge!({ user_id: current_user.id }))
    else
      user = User.find_by_email('anonymous@mail.com')
      user = User.create(email: 'anonymous@mail.com', password: '123456') if user.nil?

      @post.comments.create(comment_parms.to_h.merge!({ user_id: user.id }))
    end

    redirect_to post_path(@post)
  end

  private

  def comment_parms
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
