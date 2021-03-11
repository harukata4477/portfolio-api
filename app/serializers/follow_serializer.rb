class FollowSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attributes :followings do |object,  params|
    params[:followings]
  end

  attributes :current_user do |object, params|
    params[:current_user]
  end
end
