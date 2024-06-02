module TimestampHelper
  def format_timestamp(time)
    time.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
  end
end