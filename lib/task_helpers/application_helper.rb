module ApplicationHelper
  def self.convert_date(old_date)
    if old_date
      return Date.strptime(old_date, '%Y-%m-%dT%H:%M:%S')
    else
      return Date.strptime('01/01/2099', '%m/%d/%Y')
    end
  end
  
  def self.convert_date_time(old_date)
    if old_date
      return DateTime.strptime(old_date, '%Y-%m-%dT%H:%M:%S')
    else
      return Date.strptime('01/01/2099', '%m/%d/%Y')
    end
  end
end