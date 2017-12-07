class Project < ApplicationRecord
  include SharedAttributes
  belongs_to :user, inverse_of: :projects
  belongs_to :client, inverse_of: :projects
  has_many :tasks, inverse_of: :project, dependent: :destroy
  has_many :expenses, inverse_of: :project, dependent: :destroy

  validates :name, presence: true, length: { maximum: 254 }
  validates :description, length: { maximum: 10000 }
  validates :due_date, presence: true
  validates :status, presence: true
  validates :client, presence: true

  enum status: %i(ready_to_start in_process on_hold done archived)
end
