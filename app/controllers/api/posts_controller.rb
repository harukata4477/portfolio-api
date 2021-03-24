class Api::PostsController < ApplicationController
  def index
    posts = Post.includes(:user)
    judges = true
    json_string = PostSerializer.new(posts,{params: {judge: judges}}).serialized_json
    render json: json_string
  end

  def show
    post = Post.find(params[:id])
    json_string = PostSerializer.new(post).serialized_json
    render json: json_string
  end

  def create
    room_id = Room.find_by(title: params[:room]).id
    post = Post.new(title: params[:title], room_id: room_id)
    if post.save
      render json: {post_id: post.id}
    else
      render json: content.errors.messages
    end
  end

  def update
    post = Post.find_by(id: params[:id])
    if post.update(title: params[:title])
      render json: { success_message: '更新完了'}
    else
      render json: { errors: ['更新できませんでした。']}, status: 401
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post.destoy
      render json: { success_message: '削除完了'}
  end

  def search
    posts = Post.includes(:user).where("title LIKE(?)", "%#{params[:id]}%").page(params[:page]).per(10).order(created_at: :DESC)
    judges = true
    json_string = PostSerializer.new(posts, {params: {judge: judges}}).serialized_json
    render json: json_string
  end
end
