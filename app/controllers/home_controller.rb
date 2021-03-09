class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: 'ok'
  end
  def show
    render json:current_user, status: :ok
  end
end
