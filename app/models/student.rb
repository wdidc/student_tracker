class Student

        @@all = JSON.parse(HTTParty.get("http://api.wdidc.org/students").body)
	attr_accessor :github_id, :github_username, :name, :squad

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

	def color
	  statuses = Status.where(github_id: self.github_id)
    red = statuses.where(color: "red").length
    yellow = statuses.where(color: "yellow").length
    green = statuses.where(color: "green").length
    red += yellow/2.0
    green += yellow/2.0
    total = green + red
    green_percent = green/total.to_f
    hue = green_percent * 1.2 / 360 * 100
    rgb = hsl_to_rgb(hue, 1, 0.5)
    return "rgb(#{rgb[0]}, #{rgb[1]}, #{rgb[2]})"
	end

  def github_repo_url
    "https://github.com/#{github_username}?tab=repositories"
  end

	def updated_at
	  status = Status.where(github_id: self.github_id).last
	  if status
	    return status.updated_at
	  end
	end
end
