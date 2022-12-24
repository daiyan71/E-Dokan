class User < ApplicationRecord
  mount_uploader :image, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :ratings
  has_one :cart
  validates :contact_number, :user_name, presence: true
end
