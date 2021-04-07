class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
  belongs_to :post, optional: true
  belongs_to :user, optional: true
  has_many :notifications, dependent: :destroy
end
