module SharedAttributes
  extend ActiveSupport::Concern

  included do
    attr_accessor :set_due_date
    attr_accessor :set_status

    def set_due_date=(due_date)
      self.due_date = DateTime.strptime(due_date, '%m/%d/%Y %I:%M %p') if due_date && due_date.present?
      self.due_date ||= ''
    end

    def set_due_date
      return unless self.due_date
      self.due_date.strftime('%m/%d/%Y %I:%M %p')
    end

    def set_status=(status)
      self.status = status.parameterize.underscore if status && status.present?
      self.status ||= ''
    end

    def set_status
      self.status
    end
  end
end