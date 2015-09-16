class Student

  @@all = JSON.parse(HTTParty.get("http://api.wdidc.org/students").body)
	attr_accessor :github_id, :github_username, :name, :squad, :statuses, :tardies, :absences, :absences_total

	def initialize(opts={})
		@name = opts[:name]
		@github_id = opts[:github_id]
    @github_username = opts[:github_username]
		@squad = opts[:squad]
	end

	def self.all
	  studs = @@all.map do |student|
	    Student.new({
	      github_id: student["github_user_id"],
	      github_username: student["github_username"],
	      name: student["name"],
	      squad: student["squad"].downcase
	    })
	  end
	  studs
	end

	def self.find(id)
	  students = @@all
	  student = students.find{|student|student["github_user_id"] == id.to_i}
	  Student.new({
	    github_id: student["github_user_id"],
	    github_username: student["github_username"],
	    name: student["name"],
	    squad: student["squad"].downcase
	  })
	end

  def hue_to_rgb(p,q,t)
    if t < 0
      t += 1
    end
    if t > 1
      t -= 1
    end
    if t < 1/6.0
      return (p + (q-p) * 6 * t)
    end
    if t < 1/2.0
      return q
    end
    if t < 2/3.0
      return (p + (q - p) * (2/3.0 - t) * 6)
    end
      return p
  end

  def hsl_to_rgb(h, s, l)
    if s == 0
      b = l.to_f
      g = l.to_f
      r = l.to_f
    else
      q = l.to_f < 0.5 ? (l.to_f * (1 + s.to_f)) : (l.to_f + s.to_f - l.to_f * s.to_f)
      p = 2 * l.to_f - q;
      r = hue_to_rgb(p, q, (h + 1/3.0))
      g = hue_to_rgb(p, q, h)
      b = hue_to_rgb(p, q, (h - 1/3.0))
    end
    return [(r * 255).to_i, (g * 255).to_i,(b * 255).to_i ]
  end

  # maps overall student progress in a red to green color scheme
	def color
    green_percent = get_green_percent
    hue = green_percent * 1.2 / 360
    rgb = hsl_to_rgb(hue, 1, 0.5)
    return "rgb(#{rgb[0]}, #{rgb[1]}, #{rgb[2]})"
	end

  # converts all statuses to a scale of 1 - 100 indicating overall student progress
  def get_green_percent
    yellow = statuses.where(color: "yellow").size
    green = statuses.where(color: "green").size
    green += yellow/2.0
    total = statuses.where(color:["yellow","green","red"]).size
    (green/total.to_f * 100)
  end

  def category
    green_percent = get_green_percent
    if statuses.size >= 1
      if green_percent.to_i < 33
        return "red"
      elsif green_percent.to_i < 66
        return "yellow"
      else
        return "green"
      end
    end
    ""
  end

  def github_repo_url
    "https://github.com/#{github_username}?tab=repositories"
  end

  def self.all_by_color
    Student.all.sort do  |x, y|
      x.get_green_percent <=> y.get_green_percent
    end
  end

  def statuses
    @statuses ||= Status.where(github_id: self.github_id)
  end

	def updated_at
	  status = Status.where(github_id: self.github_id).last
	  if status
	    return status.updated_at
	  end
	end

  #####################################################################################

  def get_attendance
    att = {
      tardies: 0,
      absences: 0,
      presences: 0,
      total: 0
    }
    attendance = JSON.parse(HTTParty.get("http://api.wdidc.org/attendance/students/#{self.github_id}?access_token=").body)
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
    self.absences = att[:absences]
    self.tardies = att[:tardies]
    self.absences_total = att[:absences] + ( att[:tardies] / 4.to_f )
    att
  end
  def get_absences

  end
  def get_assignments (token_arg)
    ass = {
      missing_homeworks: 0,
      total_homeworks: 0,
      projects: []
    }
    token = token_arg
    assignments = JSON.parse(HTTParty.get("http://assignments.wdidc.org/students/#{ self.github_id }/submissions.json?access_token=#{token}").body)
    assignments.each do |e|
      if e["assignment_type"] == "project"
	      ass[:projects] << e
      end
      if e["assignment_type"] == "homework"
      	ass[:total_homeworks] += 1
        if !e["status"]
      	  ass[:missing_homeworks] += 1
      	end
      end
    end
    ass
  end
  def get_assignments_percentage(token_arg)
    assignment_obj = self.get_assignments(token_arg)
    percentage = ((assignment_obj[:missing_homeworks].to_f / assignment_obj[:total_homeworks]) * 100).to_i
  end
end
