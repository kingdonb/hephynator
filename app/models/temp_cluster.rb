class TempCluster < ApplicationRecord
  EXPIRY_DAYS = 4
  def expired?
    expiry_date <= LocalTime.current_date
  end
  def expiry_date
    created_date + EXPIRY_DAYS.days
  end
  def created_date
    created_at.to_date
  end
end
