class StatusesController < ApplicationController
  def index
      @students = HTTParty.get("http://api.wdidc.org/students")
  end
  def show
    @student = HTTParty.get("http://api.wdidc.org/students/#{params[:github_id]}").body
  end

  def create

  end

  def update

  end

  def destroy

  end
  private
  def status_params
    params.require(:status).permit(:color, :body, :github_id)
  end
end
