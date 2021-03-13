# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader
  has_many :follows
  has_many :followings, through: :follows, source: :follower
  has_many :reverse_of_follows, class_name: :'Follow', foreign_key: 'follower_id'
  has_many :followers, through: :reverse_of_follows, source: :user
  has_many :rooms
end
