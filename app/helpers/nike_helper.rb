module NikeHelper

  def avg_speed(arr)
    cumm_speed = 0
    arr.each do |r|
      cumm_speed += r.speed
    end

    return cumm_speed/arr.length
  end

end
