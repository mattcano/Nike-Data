class NikeController < ApplicationController

  include NikeHelper  

  def index
  end

  def matt
    user = Nike::Client.new(ENV['NIKE_EMAIL'], ENV['NIKE_PASSWORD'])

    @activities = user.activities(type: :run)
    @run_array = []
    wdi_time = Time.new(2013, 3, 25, 0, 0, 0, "-07:00")

    @activities.each do |r|
      run = Run.new
      run.name = r.name
      run.start = r.start_time_utc
      run.device = r.device_type
      run.calories = r.metrics.calories
      run.distance = r.metrics.distance_in_miles
      run.duration = r.metrics.duration_in_seconds
      run.steps = r.metrics.steps
      run.pace_str = run.pace_str
      run.pace = run.pace
      run.speed = run.speed
      run.duration_str = run.duration_str
      @run_array << run
    end

    wdi_arr = @run_array.select{|r| r.start > wdi_time}
    pre_arr = @run_array.select{|r| r.start < wdi_time}

    speed_wdi = {
      "graph" => {
        "title" => "Speed (MPH)", 
        "total" => false, 
        "datasequences" => [
          {
            "title" => "Before WDI", 
            "color" => "yellow", 
            "datapoints" => [
              {
                "title" => "Matt", "value" => avg_speed(pre_arr)
              }
            ]
          }, 
          {
            "title" => "After WDI", 
            "color" => "red", 
            "datapoints" => [
              {
                "title" => "Matt", 
                "value" => avg_speed(wdi_arr)
              }
            ]
          }
        ]
      }
    }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: speed_wdi}
    end
  end

end
