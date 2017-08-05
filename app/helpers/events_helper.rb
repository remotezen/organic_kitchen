module EventsHelper
  def rTime(date)
    date.strftime("%I:%M")
  end

  def name_razor(u)
    u.name
  end

  def rday(num)
    case num
      when 1
        'sunday'
      when 2
        'monday'
      when 3
        'tuesday'
      when 4
        'wednesday'

      when 5
        'thursday'
      when 6
        'friday'
      when 7
        'saturday'
    end
  end
end
