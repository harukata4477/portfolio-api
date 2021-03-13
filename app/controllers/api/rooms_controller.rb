class Api::RoomsController < ApplicationController
  def index
    user = current_user
    rooms = user.rooms.page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(rooms)
    json_string = RoomSerializer.new(user).serializable_hash.merge(pagination)
    render json: json_string
  end

  def show
    user = User.find(1)
    room = Room.find(params[:id])
    # pagination = generate_pagination(rooms)
    # json_string = RoomSerializer.new(user).serializable_hash.merge(pagination)
    json_string = RoomSerializer.new(user, {params:{search: room}})
    render json: json_string

  end

  def create
    room = Room.new(room_params)
    if room.save
      render json: { success_message: '登録完了'}
    else
      render json: room.errors.messages
    end
  end

  def update
    room = Room.find(params[:id])
    if room.update(room_params)
      render json: { success_message: '更新完了'}
    else
      render json: room.errors.messages
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    render json: { success_message: '削除完了'}
  end

  def search 
    user = current_user
    rooms = user.rooms.where("title LIKE(?)", "%#{params[:id]}%").page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(rooms)
    json_string = RoomSerializer.new(user, {params:{search: rooms}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  private

  def room_params
    params.require(:room).permit(:title, :deadline, :done).merge(user_id: current_user.id)
  end

end
