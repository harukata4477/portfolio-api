# frozen_string_literal: true

class LikeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :post_id

  attributes :posts, &:post

  attributes :like_counts do |object|
    object.post.likes.length
  end

  attributes :users do |object, _params|
    object.user
  end

  attributes :like_judges do |object, params|
    if params[:my_user]
      judge = []
      id = params[:my_user].id
      object.post.likes.map do |l|
        judge.push(true) if l.user_id == id
      end
      judge.present?
    end
  end
end
