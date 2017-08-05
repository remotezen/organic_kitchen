class Event < ApplicationRecord
  has_one :shift
  scope :reversed, -> { order 'start_time ASC' }
  scope :top, -> { order 'start_time ASC' }
  scope :shift, -> {}
  
  def self.day_of_month(day)
    where("cast(strftime('%d', start_time) as int) = ?", 
          day)
  end
end
