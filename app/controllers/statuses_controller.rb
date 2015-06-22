class StatusesController < ApplicationController
  def index
      @students = HTTParty.get("http://api.wdidc.org/students")
  end
  def show
    @student = HTTParty.get("http://api.wdidc.org/students/#{params[:github_id]}").body
  end

end
