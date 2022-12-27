module HomeHelper
  def get_session_filter_data session, filter, data
    if session[filter].present?
      if session[filter][data].present?
        return session[filter][data]
      end
    end

    return ""
  end
end
