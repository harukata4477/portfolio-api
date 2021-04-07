class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.new(message: data['message'], user_id: data['user_id'], post_id: data['post_id'])
    message.save!

    post = Post.find(message.post_id)
    notification = Notification.new(message_id: message.id, action: 'message', visitor_id: data['user_id'], visited_id: post.user_id, checked: false)
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save
  end
end
