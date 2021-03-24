class PostRelationship < ApplicationRecord
  belongs_to :post
  belongs_to :post_content
end
