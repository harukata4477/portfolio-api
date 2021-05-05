# frozen_string_literal: true

class TagSerializer
  include FastJsonapi::ObjectSerializer
  attributes :tags do |object, params|
    unless params[:judge]
      {
        id: object.id,
        name: object.name,
        taggings_count: object.taggings_count
      }
    end
  end

  attributes :posts do |object, params|
    if params[:judge]
      {
        id: object.id,
        title: object.title,
        kind: object.kind,
        tag_list: object.tag_list
      }
    end
  end

  attributes :likes do |object, params|
    object.likes if params[:judge]
  end

  attributes :like_judges do |object, params|
    if params[:judge] && (params[:current_user])
      judge = []
      id = params[:current_user].id
      object.likes.map do |like|
        judge.push(true) if like.user_id == id
      end
      judge.present?
    end
  end

  attributes :users do |object, params|
    object.user if params[:judge]
  end
end
