class Api::LikesController < ApplicationController
  def index
    posts = Post.page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(posts)
    judges = true
    my_user = current_user
    json_string = LikeSerializer.new(posts,{params: {judge: judges, page: pagination}}).serialized_json
    render json: json_string
  end

  def show
    likes = Like.preload(post: :tags, post: :likes).where(user_id: params[:id]).page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(likes)
    json_string = LikeSerializer.new(likes, {params: {my_user: current_user}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  def create
    like = current_user.likes.find_or_create_by!(post_id: params[:post_id])
    check = Notification.find_by(post_id: params[:post_id], action: 'like', visitor_id: current_user.id, visited_id: params[:user_id])
    unless check
      notification = Notification.new(post_id: params[:post_id], action: 'like', visitor_id: current_user.id, visited_id: params[:user_id], checked: false)
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save
    end
    render json: like
  end

  def destroy
    like = Like.find_by(post_id: params[:id], user_id: current_user.id)
    like.destroy
  end

end
