class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, inverse_of: :user, dependent: :destroy
  has_many :clients, inverse_of: :user, dependent: :destroy
end
