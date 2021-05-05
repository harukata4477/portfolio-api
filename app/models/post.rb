# frozen_string_literal: true

class Post < ApplicationRecord
  acts_as_taggable
  validates :kind, presence: true
  validates :room_id, presence: true
  validates :user_id, presence: true
  validates :title, presence: true

  has_many :post_contents, dependent: :destroy
  belongs_to :room, optional: true
  has_one :content, through: :room, source: :content
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
