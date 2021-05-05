# frozen_string_literal: true

class PostContent < ApplicationRecord
  mount_uploader :picture, PictureUploader
  validates :post_id, presence: true
  validates :kind, presence: true

  belongs_to :post, optional: true
end
