class Api::RoomsController < ApplicationController
  # def index
  #   @user = Room.where(user_id: current_user.id)
  #   @rooms = @user.all.order(updated_at: :desc)
  #   render json: @rooms
  # end

  # def show
  #   @user = Room.where(user_id: current_user.id)
  #   @room = @user.find_by(id: params[:id])

  #   unless @room.nil?
  #     render "show", formats: :json, handlers: "jbuilder"
  #   else
  #     render json: { error_message: 'Not Found'}
  #   end
  # end

  def create
    room = Room.new(room_params)
    if room.save
      render json: { success_message: '登録完了'}
    else
      render json: room.errors.messages
    end
  end

  # def update
  #   @user = Room.where(user_id: current_user.id)
  #   room = @user.find(params[:id])
  #   if room.update(room_params)
  #     render json: { success_message: '更新完了'}
  #   else
  #     render json: room.errors.messages
  #   end
  # end

  # def destroy
  #   @user = Room.where(user_id: current_user.id)
  #   room = @user.find(params[:id])
  #   room.destroy
  #   render json: { success_message: '削除完了'}
  # end

  # def search 
  #   @user = Room.where(user_id: current_user.id)
  #   @room = Room.where("goal LIKE(?)", "%#{params[:id]}%")
  #   render "search", formats: :json, handlers: "jbuilder"
  # end

  private

  def room_params
    params.require(:room).permit(:title, :deadline, :done).merge(user_id: current_user.id)
  end

end
