class PostContent < ApplicationRecord
  belongs_to :post, optional: true
  mount_uploader :picture, PictureUploader
end
