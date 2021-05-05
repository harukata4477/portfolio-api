# frozen_string_literal: true

class Notification < ApplicationRecord
  after_create_commit { NotificationBroadcastJob.perform_later self }
  validates :visitor_id, presence: true
  validates :visited_id, presence: true
  validates :action, presence: true

  belongs_to :post, optional: true
  belongs_to :message, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
