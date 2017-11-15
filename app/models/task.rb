class Task < ApplicationRecord
  include SharedAttributes
  belongs_to :project, inverse_of: :tasks

  validates :name, presence: true, length: { maximum: 254 }
  validates :description, length: { maximum: 10000 }
  validates :due_date, presence: true
  validates :status, presence: true
  validates :project, presence: true

  enum status: %i(ready_to_start in_progress on_hold done)
end
