class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:authenticate]
  before_action :layout
  protect_from_forgery with: :exception
  include StatusesHelper
  private
  def authenticate_user
    unless current_user
      redirect_to '/auth/github'
    end
  end
  def layout
    @notifications = Notification.where(receiver: current_user)
  end
end
