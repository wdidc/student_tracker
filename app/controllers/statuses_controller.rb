class StatusesController < ApplicationController
  def index
    @students = Student.all
  end
  def show
    @statuses = Status.where(github_id: params[:github_id]).order(:created_at).reverse
    @attendance = get_attendance
    @status = Status.new
    @status.github_id = params[:github_id]
    @student = Student.find(params[:github_id])
  end
  def get_attendance
    att = {
      tardies: 0,
      absences: 0,
      presences: 0
    }
    attendance = JSON.parse(HTTParty.get("http://api.wdidc.org/attendance/students/#{params[:github_id]}").body)
    attendance.each do |e|
     if e["status"] == "tardy"
       att[:tardies] += 1
     end
     if e["status"] == "absent"
       att[:absences] += 1
     end
     if e["status"] == "present"
       att[:presences] += 1
     end
    end
    att
  end
  def edit
    @status = Status.find(params[:id])
    @student = JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{@status.github_id}").body)
  end
  def create
    @status = Status.new(status_params.merge(author: session[:user]["name"]))
    if @status.save
      redirect_to "/#{@status.github_id}"
    end
  end

  def update
    @status = Status.find(params[:id])
    # need to be able to query for status you're updating
    @status.update(status_params.merge(author: session[:user]["name"]))
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

  def authenticate
    token = request.env['omniauth.auth'][:credentials][:token]
    session[:token] = token
    if authorize
      redirect_to root_path
    else
      error json:{error: "not authorized"}
    end
  end
  private
  def status_params
    params.require(:status).permit(:color, :body, :github_id)
  end
end
