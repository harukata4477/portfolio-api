class Post < ApplicationRecord
  acts_as_taggable
  has_many :post_contents
  # validates :room_id, uniqueness: true
  validates :room_id, presence: true
  belongs_to :room, optional: true
  has_one :content, through: :room, source: :content
  # has_one :user, through: :room, source: :user
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :messages, dependent: :destroy
end
