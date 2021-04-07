class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast 'notification_channel', notification: notification, message:notification.message, visitor: notification.visitor
  end
end
