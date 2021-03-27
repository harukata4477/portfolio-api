class Api::TagsController < ApplicationController
  def index
    tags = Post.tags_on(:tags)
    json_string = TagSerializer.new(tags).serialized_json
    render json: json_string
  end

  def show
    posts = Post.includes(:user, :tags, :likes).tagged_with(params[:id], any: true).page(params[:page]).per(10).order(created_at: :DESC)
    pagination = generate_pagination(posts)
    judges = true
    my_user = current_user
    json_string = TagSerializer.new(posts,{params: {judge: judges, current_user: my_user}}).serializable_hash.merge(pagination)
    render json: json_string
  end
end