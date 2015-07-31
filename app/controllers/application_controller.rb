class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:authenticate]
  protect_from_forgery with: :exception
  include StatusesHelper
  private
  def authenticate_user
    unless current_user
      redirect_to '/auth/github'
    end
  end
end
