class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :action, :post_id, :created_at

  attributes :visitor do |object|
    {
      id: object.visitor.id,
      name: object.visitor.name,
      image: object.visitor.image,
    }
  end

  attributes :message do |object|
    object.message
  end
end
