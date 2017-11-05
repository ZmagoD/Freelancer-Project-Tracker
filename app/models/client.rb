class Client < ApplicationRecord
  has_many :projects, inverse_of: :client
  belongs_to :user, inverse_of: :clients

  validates :full_name, presence: true, length: { maximum: 254 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :user, presence: true
end
