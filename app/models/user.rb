class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save { self.email = email.downcase }

  has_one_attached :profile_photo
  has_one_attached :bike_photo
  has_many :rides, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }, format: { with: /\A[a-zA-Z]+\z/ }
  validates :about_me, presence: true, length: { in: 20..600 }
  validates :interests, presence: true, length: { in: 10..200 }
  validates :profile_photo, presence: true
  #validates :bike_photo, presence: true
end
