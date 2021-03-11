class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :image, :profile
  

  attributes :follow_judge do |object, params|
    judge = []
    id = object.id
    params[:current_user].follows.map do |f|
      if object.id == f.follower_id
        judge.push(true)
      end
    end
    judge.present?
  end

  attributes :current_user do |object, params|
    params[:current_user]
  end

  attributes :email do |object, params|
    if params[:current_user].id == object.id
      object.email
    end
  end
end

