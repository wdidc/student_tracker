class StatusesController < ApplicationController
  def index
      @students = HTTParty.get("http://api.wdidc.org/students")
      @students_status = []
      @students.each do |student|
        stat = Status.where(github_id: student["id"]).last
        @students_status << [student, stat]
      end
  end
  def show
    @statuses = Status.where(github_id: params[:github_id]).order(:created_at).reverse
    @status = Status.new
    @status.github_id = params[:github_id]
    @student = JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{params[:github_id]}").body)
  end
  def edit
    @status = Status.find(params[:id])
    @student = JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{@status.github_id}").body)
  end
  def create
    @status = Status.new(status_params)
    if @status.save
      redirect_to "/#{@status.github_id}"
    end
  end

  def update
    @status = Status.find(params[:id])
    # need to be able to query for status you're updating
    @status.update(status_params)
    if @status.save
      redirect_to "/#{@status.github_id}"
    end
  end

  def destroy
    @status = Status.find(params[:id])
    # need to be able to query for status you're deletings
    gh = @status.github_id
    @status.destroy
    redirect_to "/#{gh}"

  end
  private
  def status_params
    params.require(:status).permit(:color, :body, :github_id)
  end
end
