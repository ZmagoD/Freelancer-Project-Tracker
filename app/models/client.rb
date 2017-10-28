class Client < ApplicationRecord
  belongs_to :project, inverse_of: :client, optional: true
  belongs_to :user, inverse_of: :clients
end
