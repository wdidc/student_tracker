class StatusesController < ApplicationController
  def index
    @students = Student.all
  end
  def show
    @statuses = Status.where(github_id: params[:github_id]).order(:created_at).reverse
    @attendance = get_attendance
    @assignments = get_assignments
    @status = Status.new
    @status.github_id = params[:github_id]
    @student = Student.find(params[:github_id])
  end
  def projects
    @assignments = get_assignments
    @student = Student.find(params[:github_id])
  end
  def get_attendance
    att = {
      tardies: 0,
      absences: 0,
      presences: 0
    }
    attendance = JSON.parse(HTTParty.get("http://api.wdidc.org/attendance/students/#{params[:github_id]}?access_token=").body)
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
  def get_assignments
    ass = {
      missing_homeworks: 0,
      projects: []
    }
    token = session[:token]
    assignments = JSON.parse(HTTParty.get("http://assignments.wdidc.org/students/#{params[:github_id]}/submissions.json?access_token=#{token}").body)
    assignments.each do |e|
      if e["assignment_type"] == "project"
	ass[:projects] << e

      end
      if e["assignment_type"] == "homework"
	if !e["status"]
	  ass[:missing_homeworks] += 1
	end
      end
    end
    ass
  end
  def edit
    @status = Status.find(params[:id])
    @student = JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{@status.github_id}").body)
  end
  def create
    @status = Status.new(status_params.merge(user: current_user))
    if @status.save
      redirect_to "/#{@status.github_id}"
    end
  end

  def update
    @status = Status.find(params[:id])
    # need to be able to query for status you're updating
    @status.update(status_params.merge(user: current_user))
    if @status.save
      redirect_to "/#{@status.github_id}"
    end
  end

  def destroy
    @status = Status.find(params[:id])
    # need to be able to query for status you're deletings
    gh = @status.github_id
    @status.destroy if @status.user == current_user
    redirect_to "/#{gh}"
  end
  def recent
    @statuses = Status.order(:created_at => :desc).limit(20).page(params[:page])
  end

  def authenticate
    token = request.env['omniauth.auth'][:credentials][:token]
    session[:token] = token
    @user = User.from_auth(request.env['omniauth.auth'])
    if @user.is_an_instructor? token
      session[:uid] = @user.uid
      redirect_to root_path
    else
      render json:{error: "not authorized"}
    end
  end

  def stats
    statuses = Status.all
    data = {}
    statuses.each do |status|
      data[status.user.name] ||= 0
      data[status.user.name] += 1
    end
    @stats = []
    data.each do |datum_key, datum_value|
      @stats << {name:datum_key,statuses:datum_value}
    end
    @stats
  end

  def groups
    @num = 13
    @students = Student.all_by_color
  end

  private
  def status_params
    params.require(:status).permit(:color, :body, :github_id)
  end
end
