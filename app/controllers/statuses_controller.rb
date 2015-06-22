class StatusesController < ApplicationController
  def index
      @students = HTTParty.get("http://api.wdidc.org/students")
  end
  def show
    @status = Status.new
    @student = JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{params[:github_id]}").body)
  end
  def create
    @status = Status.new(status_params)
    if @status.save
      redirect_to @student
    end
  end

  def update
    # need to be able to query for status you're updating
    @status.update(status_params)
    if @status.save
      redirect_to @student
    end
  end

  def destroy
    # need to be able to query for status you're deletings
    @status.destroy

  end
  private
  def status_params
    params.require(:status).permit(:color, :body, :github_id)
  end
end
