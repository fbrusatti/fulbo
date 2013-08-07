module SportCentersHelper

  def reservation_calendar(resource)
    if has_permission?(resource)
      link_to I18n.t('sport_centers.show.reservation_calendar'),
              calendar_url(resource)
    end
  end

  private
  def has_permission?(resource)
    case resource.class.to_s
    when 'SportCenter'
      current_user == resource.owner
    when 'Field'
      current_user == resource.location.sport_center.owner
    when 'Location'
      current_user == resource.sport_center.owner
    else
      false
    end
  end

  def calendar_url(resource)
    resource_kind = resource.class.to_s.tableize
    url_for :controller => 'calendars',
            :action => 'show',
            (resource_kind.singularize + '_id').to_sym => resource.id
  end
end
