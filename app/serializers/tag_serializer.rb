class TagSerializer
  include FastJsonapi::ObjectSerializer
  # attributes :id, :name, :taggings_count
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

  attributes :users do |object, params|
    if params[:judge]
      # {
      #   id: object.id,
      #   title: object.title,
      #   kind: object.kind,
      #   tag_list: object.tag_list,
      # }
      object.user
    end
  end
end
