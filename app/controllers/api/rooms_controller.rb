class Api::RoomsController < ApplicationController
  def index
<<<<<<< HEAD
    rooms = current_user.rooms.page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(rooms)
    json_string = RoomSerializer.new(rooms).serializable_hash.merge(pagination)
=======
    user = current_user
    rooms = user.rooms.page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(rooms)
    json_string = RoomSerializer.new(user).serializable_hash.merge(pagination)
>>>>>>> d2a8736f38280a784d3e1920ab575be52bf68cef
    render json: json_string
  end

  def show
<<<<<<< HEAD
    room = current_user.rooms.find_by(id: params[:id])
    json_string = RoomSerializer.new(room).serialized_json
    render json: json_string
=======
    user = User.find(1)
    room = Room.find(params[:id])
    # pagination = generate_pagination(rooms)
    # json_string = RoomSerializer.new(user).serializable_hash.merge(pagination)
    json_string = RoomSerializer.new(user, {params:{search: room}})
    render json: json_string

>>>>>>> d2a8736f38280a784d3e1920ab575be52bf68cef
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
<<<<<<< HEAD
    room = current_user.rooms.find(params[:id])
=======
    room = Room.find(params[:id])
>>>>>>> d2a8736f38280a784d3e1920ab575be52bf68cef
    if room.update(room_params)
      render json: { success_message: '更新完了'}
    else
      render json: room.errors.messages
    end
  end

  def destroy
<<<<<<< HEAD
    room = current_user.rooms.find(params[:id])
=======
    room = Room.find(params[:id])
>>>>>>> d2a8736f38280a784d3e1920ab575be52bf68cef
    room.destroy
    render json: { success_message: '削除完了'}
  end

  def search 
<<<<<<< HEAD
    # User.find(1)
    rooms = User.find(1).rooms.where("title LIKE(?)", "%#{params[:id]}%").page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(rooms)
    json_string = RoomSerializer.new(rooms).serializable_hash.merge(pagination)
=======
    user = current_user
    rooms = user.rooms.where("title LIKE(?)", "%#{params[:id]}%").page(params[:page]).per(10).order(created_at: :desc)
    pagination = generate_pagination(rooms)
    json_string = RoomSerializer.new(user, {params:{search: rooms}}).serializable_hash.merge(pagination)
>>>>>>> d2a8736f38280a784d3e1920ab575be52bf68cef
    render json: json_string
  end

  private

  def room_params
    params.require(:room).permit(:title, :deadline, :done).merge(user_id: current_user.id)
  end

end
