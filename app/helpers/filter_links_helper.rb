module FilterLinksHelper
  def current?(current_status, status)
    status == current_status ? 'bg-warning' : ''
  end
end
