class MessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :message, :created_at

  attributes :users do |object|
    {
      id: object.user.id,
      name: object.user.name,
      image: object.user.image
    }
  end

  attributes :posts do |object, params|
    params[:posts]
  end
end
