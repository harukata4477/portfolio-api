class TagSerializer
  include FastJsonapi::ObjectSerializer
  attributes :tags do |object, params|
    unless params[:judge]
      {
        id: object.id,
        name: object.name,
        taggings_count: object.taggings_count,
      }
    end
  end

  attributes :posts do |object, params|
    if params[:judge]
      {
        id: object.id,
        title: object.title,
        kind: object.kind,
        tag_list: object.tag_list,
      }
    end
  end

  attributes :likes do |object, params|
    if params[:judge]
      object.likes
    end
  end

  attributes :like_judges do |object, params|
    if params[:judge]
      if params[:current_user]
        judge = []
        id = params[:current_user].id
        object.likes.map do |like|
          if like.user_id == id
            judge.push(true)
          end
        end
        judge.present?
      end
    end
  end

  attributes :users do |object, params|
    if params[:judge]
      object.user
    end
  end
end
