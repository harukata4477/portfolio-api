# frozen_string_literal: true

class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :message, presence: true

  belongs_to :post, optional: true
  belongs_to :user, optional: true
  has_many :notifications, dependent: :destroy
end
