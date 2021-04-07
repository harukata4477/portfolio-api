class Api::FollowsController < ApplicationController
  def show
    user = User.preload(:followings).find(params[:id])
    following = user.followings.page(params[:page]).page(params[:page]).per(10).order(created_at: :DESC)
    pagination = generate_pagination(following)
    json_string = FollowSerializer.new(user, {params: {followings: following}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  def show_follower
    user = User.preload(:followers).find(params[:id])
    judge = true
    follower = user.followers.page(params[:page]).page(params[:page]).per(10).order(created_at: :DESC)
    pagination = generate_pagination(follower)
    json_string = FollowSerializer.new(user, {params: {judges: judge, followers: follower}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  def create
    follower = User.find(params[:user_id])
    unless current_user == follower
      current_user.follows.find_or_create_by(follower_id: follower.id)
    end

    check = Notification.find_by(action: 'follow', visitor_id: current_user.id, visited_id: params[:user_id])
    unless check
      notification = Notification.new(action: 'follow', visitor_id: current_user.id, visited_id: params[:user_id], checked: false)
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save
    end
  end
  
  def destroy
    follower = User.find(params[:id])
    relationship = current_user.follows.find_by(follower_id: follower.id)
    relationship.destroy 
  end
end
