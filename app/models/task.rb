class Task < ApplicationRecord
  belongs_to :project, inverse_of: :tasks

  validates :name, presence: true, length: { maximum: 254 }
  validates :description, length: { maximum: 10000 }
  validates :due_date, presence: true
  validates :status, presence: true
  validates :project, presence: true

  enum status: %i(in_process on_hold done archived)
end
