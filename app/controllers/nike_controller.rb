class NikeController < ApplicationController

  include NikeHelper  

  before_filter :fetch_data, :only => [:speed, :d3]

  def fetch_data
    user = Nike::Client.new(ENV['NIKE_EMAIL'], ENV['NIKE_PASSWORD'])
    
    @activities = user.activities(type: :run)

    @run_array = @activities.map do |r|
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
      run
    end
  end

  def index
  end

  def months(num_months)
    months_arr = []
    begin
      t1 = num_months.months.ago.to_date.beginning_of_month
      t2 = num_months.month.ago.to_date.end_of_month
      months_arr << (t1..t2)
      num_months -= 1
      # binding.pry
    end while num_months >= 0
    return months_arr
  end

# takes an array of months as date ranges and returns an hash of names of months MMM YY
  def months_data_initialize(arr)
    names = Hash.new{|hash, key| hash[key] = 0}
    arr.each do |m|
      names[m.begin.strftime('%b %y')]
    end
    return names
  end

  def d3  
    months_arr = months(24)
    data = months_data_initialize(months_arr)
    @run_array.each do |run|
      months_arr.each do |m|
        data[m.begin.strftime('%b %y')] += 1 if m.include?(run.start.to_date)
      end
    end

    data_output = data.map { |key, value| {:XVal => key, :YVal => value}}
    data_array = data.map{|key, value| value}
    
    render json: data_array
  end

  def d3_show
  end

  def speed
    wdi_time = Time.new(2013, 3, 25, 0, 0, 0, "-07:00")

    wdi_arr, pre_arr  = @run_array.partition{|r| r.start > wdi_time}

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
