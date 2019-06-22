module StatusBadge
  extend ActiveSupport::Concern

  def status_text
    if self.terminated? || !self.activated?
      "(Inactive)"
    else
      "Active"
    end
  end
  def status_badge
    if self.terminated?
      %Q{<span class="status dead">#{status_text}</span>}
    elsif !self.activated?
      %Q{<span class="status inactive">#{status_text}</span>}
    else
      %Q{<span class="status alive">#{status_text}</span>}
    end
  end
end
