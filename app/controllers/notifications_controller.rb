class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(receiver: current_user).order(created_at: :desc)
  end
  def update
    @notification = Notification.find(params[:id])
    @notification.update(notification_params)
    respond_to do |format| 
      format.json { render json: @notifications_count }
    end
  end
  private
  def notification_params
    params.require(:notification).permit(:read)
  end
end