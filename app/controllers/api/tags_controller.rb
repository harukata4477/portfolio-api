# frozen_string_literal: true

module Api
  class TagsController < ApplicationController
    def index
      tags = Post.tags_on(:tags)
      data = TagSerializer.new(tags).serialized_json
      render json: data
    end

    def show
      posts = Post.includes(:user, :tags, :likes).tagged_with(params[:id],
                                                              any: true).page(params[:page]).per(10).order(created_at: :DESC)
      pagination = generate_pagination(posts)
      limit = true
      my_user = current_user
      data = TagSerializer.new(posts,
                               { params: { judge: limit,
                                           current_user: my_user } }).serializable_hash.merge(pagination)
      render json: data
    end
  end
end
