class Expense < ApplicationRecord
  belongs_to :project, inverse_of: :expenses

  validates :amount, presence: true
  validates :project, presence: true
end
