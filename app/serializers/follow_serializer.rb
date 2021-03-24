class FollowSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attributes :followings do |object,  params|
    params[:followings]
  end
end
