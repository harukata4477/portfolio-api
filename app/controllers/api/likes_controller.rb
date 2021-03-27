class Api::LikesController < ApplicationController
  def index
    # posts = Post.preload(:likes).where(id: current_user.id)
    # render json: posts
    posts = Post.page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(posts)
    judges = true
    my_user = current_user
    json_string = LikeSerializer.new(posts,{params: {judge: judges, page: pagination}}).serialized_json
    render json: json_string
  end

  def show
    likes = Like.eager_load(post: :tags, post: :likes).where(user_id: params[:id]).page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(likes)
    json_string = LikeSerializer.new(likes, {params: {my_user: current_user}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  def create
    like = current_user.likes.find_or_create_by!(post_id: params[:post_id])
    render json: like
  end

  def destroy
    like = Like.find_by(post_id: params[:id], user_id: current_user.id)
    like.destroy
  end

end
