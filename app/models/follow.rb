# frozen_string_literal: true

class Follow < ApplicationRecord
  validates :follower_id, presence: true
  validates :user_id, presence: true

  belongs_to :user, optional: true
  belongs_to :follower, class_name: 'User', optional: true
end
