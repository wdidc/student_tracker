class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(receiver: current_user)
  end
end