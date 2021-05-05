# frozen_string_literal: true

module Api
  class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:destroy]
    def index
      posts = Post.page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(posts)
      data = LikeSerializer.new(posts, { params: { page: pagination } }).serialized_json
      render json: data
    end

    def show
      likes = Like.preload(post: :tags).where(user_id: params[:id]).page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(likes)
      data = LikeSerializer.new(likes, { params: { my_user: current_user } }).serializable_hash.merge(pagination)
      render json: data
    end

    def create
      like = current_user.likes.find_or_create_by!(post_id: params[:post_id])
      check = Notification.find_by(post_id: params[:post_id], action: 'like', visitor_id: current_user.id,
                                   visited_id: params[:user_id])
      unless check
        notification = Notification.new(post_id: params[:post_id], action: 'like', visitor_id: current_user.id,
                                        visited_id: params[:user_id], checked: false)
        notification.checked = true if notification.visitor_id == notification.visited_id
        notification.save
      end
      render json: like
    end

    def destroy
      like = Like.find_by(post_id: params[:id], user_id: current_user.id)
      like.destroy
      render json: { success_message: '削除完了' }
    end
  end
end
