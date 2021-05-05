# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :method_name, raise: false

  before_action :split_tokens
  prepend_after_action :join_tokens

  private

  def split_tokens
    return if request.headers['X-Access-Token'].nil?

    token = JSON.parse(Base64.decode64(CGI.unescape(request.headers['X-Access-Token'])))
    request.headers['access-token'] = token['access-token']
    request.headers['client'] = token['client']
    request.headers['uid'] = token['uid']
  end

  def join_tokens
    return if response.headers['access-token'].nil?

    auth_json = {
      'access-token' => response.headers['access-token'],
      'client' => response.headers['client'],
      'uid' => response.headers['uid']
    }
    response.headers.delete_if { |key| auth_json.include? key }
    response.headers['X-Access-Token'] = CGI.escape(Base64.encode64(JSON.dump(auth_json)))
  end

  def render_json(serializer, obj, options = {})
    return render_collection(serializer, obj, options) if obj.instance_of?(ActiveRecord::Relation)

    render_record(serializer, obj, options)
  end

  def render_collection(serializer, collection, options = {})
    options = meta_pagination(collection, options)
    render_record(serializer, collection, options)
  end

  def render_record(serializer, record, options = {})
    render json: serializer.new(record, options)
  end

  def meta_pagination(paginated_obj, options = {})
    options[:meta] = {} unless options.key?(:meta)
    meta_options = options[:meta].merge(generate_pagination(paginated_obj))
    options[:meta] = meta_options
    options
  end

  def generate_pagination(paginated_obj)
    {
      pagination: {
        current_page: paginated_obj.current_page,
        total_pages: paginated_obj.total_pages
      }
    }
  end
end
