class Client < ApplicationRecord
  belongs_to :project, inverse_of: :client
  belongs_to :user, inverse_of: :clients
end
