class Api::TagsController < ApplicationController
  def index
    tags = Post.tags_on(:tags)
    json_string = TagSerializer.new(tags).serialized_json
    render json: json_string
  end

  def show
    posts = Post.eager_load(:user).tagged_with([params[:id]], any: true).page(params[:page]).per(10).order(created_at: :DESC)
    pagination = generate_pagination(posts)
    judges = true
    json_string = TagSerializer.new(posts,{params: {judge: judges}}).serializable_hash.merge(pagination)
    render json: json_string
  end
end
