class Api::MessagesController < ApplicationController
  def show
    messages = Message.eager_load(:post, :user).where(post_id: params[:id]).page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(messages)
    post = Post.find(params[:id])
    json_string = MessageSerializer.new(messages, {params:{posts: post}}).serializable_hash.merge(pagination)
    render json: json_string
  end
end
