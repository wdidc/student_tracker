class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:authenticate]
  protect_from_forgery with: :exception
  def current_user
    User.find_by(uid: session[:uid])
  end
  private
  def authenticate_user
    unless current_user
      redirect_to '/auth/github'
    end
  end
end
