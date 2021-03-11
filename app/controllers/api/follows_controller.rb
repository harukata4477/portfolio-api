class Api::FollowsController < ApplicationController
  def show
    user = User.find(params[:id])
    following = user.followings.page(params[:page]).page(params[:page]).per(10).order(created_at: :DESC)
    pagination = generate_pagination(following)
    current_users = current_user
    json_string = FollowSerializer.new(user, {params: {followings: following, current_user: current_users}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  def create
    follower = User.find(params[:user_id])
    unless current_user == follower
      current_user.follows.find_or_create_by(follower_id: follower.id)
    end
  end
  
  def destroy
    follower = User.find(params[:id])
    relationship = current_user.follows.find_by(follower_id: follower.id)
    relationship.destroy 
  end
end
