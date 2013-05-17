class Run < ActiveRecord::Base
  
  #duration is in seconds, distance is in miles
  attr_accessible :calories, :device, :distance, :duration, 
                  :name, :start, :steps, :pace_str, :pace, :speed, :duration_str

  # returns pace in seconds per mile
  def pace
    return self.duration/self.distance
  end

  # returns pace in minutes per mile mm:ss
  def pace_str
    pace = self.duration / self.distance
    seconds = (pace%60).round.to_s
    minutes = (pace/60).floor.to_s
    return minutes + ":" + seconds
  end

  # returns pace in mph
  def speed
    time_in_hrs = self.duration/60/60
    return self.distance/time_in_hrs
  end

  #returns duration as string mm:ss
  def duration_str
    seconds = (self.duration%60).round.to_s
    minutes = (self.duration/60).floor.to_s
    return minutes + ":" + seconds
  end

end
