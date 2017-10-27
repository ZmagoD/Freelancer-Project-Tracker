class Expense < ApplicationRecord
  belongs_to :project, inverse_of: :expenses
end
