# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!, only: %i[update destroy]
    def index
      users = User.preload(:follows).page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(users)
      my_user = current_user
      data = UserSerializer.new(users,
                                { params: { current_user: my_user } }).serializable_hash.merge(pagination)
      render json: data
    end

    def show
      user = User.preload(:follows, :followers).find(params[:id])
      my_user = current_user
      data = UserSerializer.new(user, { params: { current_user: my_user } }).serialized_json
      render json: data
    end

    def search
      users = User.preload(:follows).where('name LIKE(?)',
                                           "%#{params[:id]}%").page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(users)
      my_user = current_user
      data = UserSerializer.new(users,
                                { params: { current_user: my_user } }).serializable_hash.merge(pagination)
      render json: data
    end

    def update
      user = User.find(params[:id])
      if current_user == user
        user.update(user_params)
        render json: user
      else
        render json: { errors: ['更新できませんでした。'] }, status: 401
      end
    end

    def destroy
      user = User.find(params[:id])
      if current_user == user
        user.destroy
        render json: { success_message: '削除が完了しました。' }
      end
    end

    private

    def user_params
      params.permit(:name, :profile, :image)
    end
  end
end
