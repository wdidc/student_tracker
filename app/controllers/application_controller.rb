class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:authenticate]


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def authenticate_user
    unless session[:token]
      redirect_to '/auth/github'
    end
    # unless current user
      # initiate oauth flow

  end
end
