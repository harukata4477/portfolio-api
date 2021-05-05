# frozen_string_literal: true

class FollowSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attributes :followings do |_object, params|
    params[:followings] unless params[:judge]
  end

  attributes :followers do |object, params|
    object.followers if params[:judge]
  end
end
