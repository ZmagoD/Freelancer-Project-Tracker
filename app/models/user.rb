class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, inverse_of: :user, dependent: :destroy
  has_many :clients, inverse_of: :user, dependent: :destroy
  store :settings, accessors: :currency, coder: JSON

  validates :currency, presence: true, length: { maximum: 5 }
  validates :full_name, presence: true, length: { maximum: 50 }
end
