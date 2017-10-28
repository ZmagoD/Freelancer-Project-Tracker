class Project < ApplicationRecord
  belongs_to :user, inverse_of: :projects
  has_one :client, inverse_of: :project
  has_many :tasks, inverse_of: :project
  has_many :expenses, inverse_of: :project

  validates :name, presence: true, length: { maximum: 254}
  validates :description, length: { maximum: 512}
  validates :due_date, presence: true
  validates :status, presence: true
  validates :client, presence: true

  enum status: %i(in_process on_hold done archived)
end
