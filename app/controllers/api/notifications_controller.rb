# frozen_string_literal: true

module Api
  class NotificationsController < ApplicationController
    before_action :authenticate_user!, only: %i[index update all_update]
    def index
      notifications = Notification.eager_load(:message, :visitor).where(visited_id: current_user.id,
                                                                        checked: false).page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(notifications)
      data = NotificationSerializer.new(notifications).serializable_hash.merge(pagination)
      render json: data
    end

    def all_update
      notifications = Notification.where(visited_id: params[:user_id], checked: false)
      notifications.update_all(checked: true)
    end

    def update
      notification = Notification.find_by(id: params[:id], visited_id: params[:user_id], checked: false)
      if notification.update(checked: true)
        render json: { success_message: '更新完了' }
      else
        render json: { error_message: '更新失敗しました。' }
      end
    end

    private

    def notification_params
      params.permit(:visitor_id, :visited_id, :post_id, :message_id, :follow_id, :action, :checked)
    end
  end
end
