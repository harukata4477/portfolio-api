# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :image, :profile

  attributes :follow_judge do |object, params|
    if params[:current_user]
      judge = []
      params[:current_user].follows.map do |f|
        judge.push(true) if object.id == f.follower_id
      end
      judge.present?
    end
  end

  attributes :email do |object, params|
    if params[:current_user].id == object.id
      object.email
    end
  end

  attributes :following do |object, _params|
    object.follows.length
  end

  attributes :follower do |object, _params|
    object.followers.length
  end
end
