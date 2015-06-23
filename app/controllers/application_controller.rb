class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:authenticate]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def authorize
    # get all instructors
    instructors = HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{session[:token]}")
    user = HTTParty.get("https://api.github.com/user?access_token=#{session[:token]}")
    begin
      instructors.each do |instructor|
        if user[:id] == instructor[:id]
          return true
        end
      end
    rescue
    end
    return false
    # get user
    # if user == instructor continue with operation
    # else throw error
  end
  def authenticate_user
    unless session[:token]
      redirect_to '/auth/github'
    end
    # unless current user
      # initiate oauth flow

  end
end
