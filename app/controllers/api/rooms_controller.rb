class Api::RoomsController < ApplicationController
  def index
    rooms = current_user.rooms.page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(rooms)
    json_string = RoomSerializer.new(rooms).serializable_hash.merge(pagination)
    render json: json_string
  end

  def show
    room = current_user.rooms.find_by(id: params[:id])
    json_string = RoomSerializer.new(room).serialized_json
    render json: json_string
  end

  def create
    room = Room.new(room_params)
    if room.save
      render json: { room_id: room.id}
    else
      render json: room.errors.messages
    end
  end

  def update
    room = current_user.rooms.find(params[:id])
    if room.update(room_params)
      render json: { success_message: '更新完了'}
    else
      render json: room.errors.messages
    end
  end

  def destroy
    room = current_user.rooms.find(params[:id])
    room.destroy
    render json: { success_message: '削除完了'}
  end

  def search 
    # User.find(1)
    rooms = User.find(1).rooms.where("title LIKE(?)", "%#{params[:id]}%").page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(rooms)
    json_string = RoomSerializer.new(rooms).serializable_hash.merge(pagination)
    render json: json_string
  end

  private

  def room_params
    params.require(:room).permit(:title, :deadline, :done).merge(user_id: current_user.id)
  end

end
