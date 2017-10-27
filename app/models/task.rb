class Task < ApplicationRecord
  belongs_to :project, inverse_of: :tasks

  validates :name, presence: true, length: { maximum: 254 }
  validates :description, length: { maximum: 10000 }

end
