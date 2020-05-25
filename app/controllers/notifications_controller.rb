class NotificationsController < ApplicationController
  def notify
    @n = Rpush::Gcm::Notification.new
    @n.app = Rpush::Gcm::App.find_by_name("kirill-3a9e2")
    @n.registration_ids = Rails.application.credentials.fcm[:server_key]

    @user = session_user if session_user

    @n.notification = JSON.parse(@user.notifications.last.to_json)
    @n.data = { message: "Hi #{@user.email}!" }
    @n.priority = 'high',
    @n.content_available = true
    @n.save!

    Rpush.push

    render json: { sent: true }, status: :ok
    # render json: @n
  end

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
