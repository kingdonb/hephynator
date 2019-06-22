class LocalTime
  TIME_ZONE = 'America/New_York'.freeze

  def self.current_date
    time_now.in_time_zone(TIME_ZONE).to_date
  end

  def self.end_of_current_month
    current_date.end_of_month
  end

  def self.nth_of_current_month(nth)
    current_date.change(day: nth)
  end

  private
  def self.time_now
    Time.now
  end
end
