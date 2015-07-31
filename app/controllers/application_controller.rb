class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:authenticate]
  protect_from_forgery with: :exception
  def current_user
    User.find_by(uid: session[:uid])
  end
  private
  def authorize
    instructors = HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{session[:token]}")
    user = HTTParty.get("https://api.github.com/user?access_token=#{session[:token]}")
    session[:user] = user
    begin
      instructors.each do |instructor|
        if user[:id] == instructor[:id]
          return true
        end
      end
    rescue
    end
    return false
  end
  def authenticate_user
    unless current_user
      redirect_to '/auth/github'
    end
  end
end
