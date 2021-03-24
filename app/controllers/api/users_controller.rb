class Api::UsersController < ApplicationController
  def index
    users = User.preload(:follows).page(params[:page]).per(10).order(created_at: :DESC)
    pagination = generate_pagination(users)
    current_users = current_user
    json_string = UserSerializer.new(users, {params: {current_user: current_users}}).serializable_hash.merge(pagination)
    render json: json_string
  end
  
  def show
    user = User.find(params[:id])
    current_users = current_user
    json_string = UserSerializer.new(user, {params: {current_user: current_users}}).serialized_json
    render json: json_string
  end

  def search
    users = User.preload(:follows).where("name LIKE(?)", "%#{params[:id]}%").page(params[:page]).per(10).order(created_at: :DESC)
    pagination = generate_pagination(users)
    current_users = current_user
    json_string = UserSerializer.new(users, {params: {current_user: current_users}}).serializable_hash.merge(pagination)
    render json: json_string
  end

  def update
    user = User.find(params[:id])
    if current_user == user
      user.update(user_params)
      render json: user
    else
      render json: { errors: ['更新できませんでした。']}, status: 401
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user == user
      user.destroy
      render json: { success_message: "削除が完了しました。"}
    end
  end

  private
    def user_params
      params.permit(:email, :name, :profile, :image)
    end
end