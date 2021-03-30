class Api::CalendarsController < ApplicationController
  def index
    calendars = Calendar.eager_load(:user).where(user_id: current_user.id)
    json_string = CalendarSerializer.new(calendars).serialized_json
    render json: json_string
  end

  def show
    user = Calendar.eager_load(:user).where(user_id: 1)
    calendar_year = user.where(start: params[:id].in_time_zone.all_year)
    calendar_month = calendar_year.where(start: params[:id].in_time_zone.all_month)
    calendar_day = calendar_month.where(start: params[:id].in_time_zone.all_day)
    json_string = CalendarSerializer.new(calendar_day).serialized_json
    render json: json_string
  end

  def create
    calendar = Calendar.new(calendar_params)
    if calendar.save
      render json: calendar
    else
      render json: { error_message: '新規登録失敗しました。'}
    end
  end

  def update
    calendar = Calendar.find_by(id: params[:id])
    if calendar.update(calendar_params)
      render json: calendar
    else
      render json: { error_message: '更新失敗しました。'}
    end
  end

  def destroy
  end

  private
    def calendar_params
      params.require(:calendar).permit(:name, :color, :start, :end, :done).merge(user_id: current_user.id)
    end
end
