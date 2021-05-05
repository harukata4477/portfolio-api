# frozen_string_literal: true

module Api
  class ContentsController < ApplicationController
    before_action :authenticate_user!, only: %i[create update]
    def show
      content = Content.eager_load(:room).find_by(room_id: params[:id])
      data = ContentSerializer.new(content).serialized_json
      render json: data
    end

    def create
      content = Content.new(content: params[:content], room_id: params[:room_id])
      if content.save
        render json: 'ok'
      else
        render json: { error_message: '新規登録失敗しました。' }
      end
    end

    def update
      content = Content.find_by(room_id: params[:id])
      if content.update(content: params[:content], room_id: params[:room_id])
        render json: content
      else
        render json: { errors: ['更新できませんでした。'] }, status: 401
      end
    end
  end
end
