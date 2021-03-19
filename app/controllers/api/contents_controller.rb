class Api::ContentsController < ApplicationController
  def show
    content = Content.find_by(room_id: params[:id])
    json_string = ContentSerializer.new(content).serialized_json
    render json: json_string
  end

  def create
      content = Content.new(content: params[:content], room_id: params[:room_id])
      if content.save
        render json: 'ok'
      else
        render json: content.errors.messages
      end
  end

  def update
    content = Content.find_by(room_id: params[:id])
    if content.update(content: params[:content], room_id: params[:room_id])
      render json: content
    else
      render json: { errors: ['更新できませんでした。']}, status: 401
    end
  end

  private

  def content_params
    params.permit(:room_id, :content => [])
  end
end
