# frozen_string_literal: true

module Api
  class FollowsController < ApplicationController
    before_action :authenticate_user!, only: %i[create destroy]
    def show
      user = User.preload(:followings).find(params[:id])
      set_followings = user.followings.page(params[:page]).page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(set_followings)
      data = FollowSerializer.new(user,
                                  { params: { followings: set_followings } }).serializable_hash.merge(pagination)
      render json: data
    end

    def show_follower
      user = User.preload(:followers).find(params[:id])
      only_followers = true
      set_followers = user.followers.page(params[:page]).page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(set_followers)
      data = FollowSerializer.new(user,
                                  { params: { judge: only_followers,
                                              followers: set_followers } }).serializable_hash.merge(pagination)
      render json: data
    end

    def create
      follow = User.find(params[:user_id])
      current_user.follows.find_or_create_by(follower_id: follow.id) unless current_user == follow

      check = Notification.find_by(action: 'follow', visitor_id: current_user.id, visited_id: params[:user_id])
      unless check
        notification = Notification.new(action: 'follow', visitor_id: current_user.id, visited_id: params[:user_id],
                                        checked: false)
        notification.checked = true if notification.visitor_id == notification.visited_id
        if notification.save
          render json: '登録完了'
        else
          render json: { error_message: '新規登録失敗しました。' }
        end
      end
    end

    def destroy
      follow = User.find(params[:id])
      relationship = current_user.follows.find_by(follower_id: follow.id)
      if relationship.destroy
        render json: { success_message: '削除完了' }
      else
        render json: { errors: ['削除できませんでした。'] }, status: 401
      end
    end
  end
end
