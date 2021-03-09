class Api::HelloController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: "api is ok"
  end
end
