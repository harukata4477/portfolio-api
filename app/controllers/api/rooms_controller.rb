# frozen_string_literal: true

module Api
  class RoomsController < ApplicationController
    before_action :authenticate_user!,
                  only: %i[index show create update destroy room_done room_not_yet search]
    def index
      rooms = current_user.rooms.page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(rooms)
      data = RoomSerializer.new(rooms).serializable_hash.merge(pagination)
      render json: data
    end

    def show
      room = current_user.rooms.find_by(id: params[:id])
      data = RoomSerializer.new(room).serialized_json
      render json: data
    end

    def create
      room = Room.new(room_params)
      if room.save
        render json: { room_id: room.id }
      else
        render json: { error_message: '新規登録失敗しました。' }
      end
    end

    def update
      room = current_user.rooms.find(params[:id])
      if room.update(room_params)
        render json: { success_message: '更新完了' }
      else
        render json: { error_message: '更新失敗しました。' }
      end
    end

    def destroy
      room = current_user.rooms.find(params[:id])
      if room.destroy
        render json: { success_message: '削除完了' }
      else
        render json: { errors: ['削除できませんでした。'] }, status: 401
      end
    end

    def search
      rooms = current_user.rooms.where('title LIKE(?)',
                                       "%#{params[:id]}%").page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(rooms)
      data = RoomSerializer.new(rooms).serializable_hash.merge(pagination)
      render json: data
    end

    def all
      rooms = current_user.rooms
      data = RoomSerializer.new(rooms).serialized_json
      render json: data
    end

    def room_done
      rooms = current_user.rooms.where(done: true).page(params[:page]).per(10).order(created_at: :DESC)
      room_count = current_user.rooms.count
      pagination = generate_pagination(rooms)
      data = RoomSerializer.new(rooms,
                                { params: { room_counts: room_count } }).serializable_hash.merge(pagination)
      render json: data
    end

    def room_not_yet
      rooms = current_user.rooms.where(done: false).page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(rooms)
      data = RoomSerializer.new(rooms).serializable_hash.merge(pagination)
      render json: data
    end

    private

    def room_params
      params.require(:room).permit(:title, :deadline, :done).merge(user_id: current_user.id)
    end
  end
end
