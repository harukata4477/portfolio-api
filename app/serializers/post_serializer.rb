# frozen_string_literal: true

class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :room_id, :user_id, :updated_at, :kind

  attributes :contents do |object, params|
    object.content unless params[:judge]
  end

  attributes :rooms do |object, params|
    unless params[:judge]
      {
        id: object.room.id,
        user_id: object.room.user_id,
        title: object.room.title,
        done: object.room.done,
        deadline: object.room.deadline
      }
    end
  end

  attributes :users do |object, _params|
    {
      id: object.user.id,
      name: object.user.name,
      image: object.user.image
    }
  end

  attributes :likes, &:likes

  attributes :like_judges do |object, params|
    if params[:current_user]
      judge = []
      id = params[:current_user].id
      object.likes.map do |like|
        judge.push(true) if like.user_id == id
      end
      judge.present?
    end
  end

  attributes :tag_list do |object|
    object.tags.pluck(:name)
  end

  attributes :post_contents do |object, params|
    object.post_contents.order('order_num') unless params[:judge]
  end

  attributes :messages do |object, params|
    object.messages unless params[:judge]
  end
end
