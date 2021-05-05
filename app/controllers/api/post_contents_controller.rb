# frozen_string_literal: true

module Api
  class PostContentsController < ApplicationController
    before_action :authenticate_user!, only: %i[create update destroy]
    def show
      post = PostContent.find(params[:id])
      data = PostSerializer.new(post).serialized_json
      render json: data
    end

    def create
      post = PostContent.new(post_content_params)
      if post.save
        render json: '登録完了'
      else
        render json: { error_message: '新規登録失敗しました。' }
      end
    end

    def update
      post_content = PostContent.find_by(id: params[:id])
      if post_content.update(post_content_params)
        render json: post_content
      else
        render json: { errors: ['更新できませんでした。'] }, status: 401
      end
    end

    def destroy
      post_content = PostContent.find_by(id: params[:id])
      if post_content.destroy
        render json: { success_message: '削除完了' }
      else
        render json: { errors: ['削除できませんでした。'] }, status: 401
      end
    end

    private

    def post_content_params
      params.permit(:post_id, :kind, :order_num, :title, :sub_title, :text, :picture)
    end
  end
end
