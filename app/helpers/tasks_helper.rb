module TasksHelper
  def task_stauses
    Task.statuses.keys.map { |value| value.humanize }
  end
end
