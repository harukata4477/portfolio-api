class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :room_id, :updated_at

  attributes :contents do |object, params|
    if params[:judge]
    else
      object.content
    end
  end

  attributes :rooms do |object, params|
    if params[:judge]
    else
      {
        id: object.room.id, 
        user_id: object.room.user_id,
        title: object.room.title,
        done: object.room.done,
        deadline: object.room.deadline,
      }
    end
  end

  attributes :users do |object|
    {
      id: object.user.id, 
      name: object.user.name,
      image: object.user.image,
    }
  end

  attributes :post_contents do |object, params|
    if params[:judge]
    else
      object.post_contents.order("order_num")
    end
  end
end
