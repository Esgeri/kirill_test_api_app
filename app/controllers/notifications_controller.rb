class NotificationsController < ApplicationController
  def create
    @user = session_user if session_user
    @notification = @user.notifications.create(notifications_params)
    render json: @notification
  end

  private

  def notifications_params
    params.permit(:title, :body, :push_time)
  end
end
