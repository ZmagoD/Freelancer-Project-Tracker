module ProjectsHelper
  def project_stauses
    Project.statuses.keys.map { |value| value.humanize }
  end

  def user_clients
    options_from_collection_for_select(current_user.clients, 'id', 'full_name')
  end
end
