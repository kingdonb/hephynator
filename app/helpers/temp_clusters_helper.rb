module TempClustersHelper
  def terminated?
    @temp_cluster.terminated?
  end
  def activated?
    @temp_cluster.activated?
  end
  def cluster_status_badge
    @temp_cluster.status_badge.html_safe
  end
  def cluster_name
    <<~HTML.strip.html_safe
      <span class="cluster_name">#{ @temp_cluster.cluster_name }</span>
    HTML
  end
  def terminated_at
    <<~HTML.strip.html_safe
      <span class="terminated_at">#{ @temp_cluster.terminated_at }</span>
    HTML
  end
  def expiry_date
    <<~HTML.strip.html_safe
      <span class="expiry_date">#{ @temp_cluster.long_expiry_date }</span>
    HTML
  end
end
