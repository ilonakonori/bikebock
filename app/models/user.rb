class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :rides, dependent: :destroy
  # validations
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }, format: { with: /\A[a-zA-Z]+\z/ }
  validates :about_me, presence: true, length: { in: 20..600 }
  validates :photo, presence: true
  validates :date_of_birth, presence: true

  # validate date => custom method
  validate :date_of_birth_validation

  def date_of_birth_validation # mmaybe? min & max => JS datepicker or smtng?
    if date_of_birth.present? && date_of_birth > (Date.today.year - 16)
      errors.add(:date_of_birth, "You have to be at least 16 years old")
    end
  end

  def age
    ((Date.today - date_of_birth).to_i / 365.242199).floor
  end
end
