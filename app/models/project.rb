class Project < ApplicationRecord
  belongs_to :user, inverse_of: :projects
  has_one :client, inverse_of: :project
  has_many :tasks, inverse_of: :project
  has_many :expenses, inverse_of: :project
end
