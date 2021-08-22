require 'rails_helper'

RSpec.describe Ride, type: :model do
  # relations
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many :requests }
  it { is_expected.to have_many :bookings }
  it { is_expected.to have_many :reviews }
  # attached files
  it { is_expected.to have_one_attached :photo_1 }
  it { is_expected.to have_one_attached :photo_2 }
  it { is_expected.to have_one_attached :photo_3 }
  # validations
  ##presence
  it { is_expected.to validate_presence_of :photo_1 }
  it { is_expected.to validate_presence_of :photo_2 }
  it { is_expected.to validate_presence_of :photo_3 }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :short_description }
  it { is_expected.to validate_presence_of :number_of_people }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }
  it { is_expected.to validate_presence_of :start_location }
  it { is_expected.to validate_presence_of :end_location }
  it { is_expected.to validate_presence_of :difficulty }
  it { is_expected.to validate_presence_of :available_dates }
  ##other
  # it { is_expected.to validate_uniqueness_of :title }
  it { is_expected.to validate_length_of(:title).is_at_least(2).on(:create) }
  it { is_expected.to validate_length_of(:title).is_at_most(26).on(:create) }
  it { is_expected.to validate_length_of(:short_description).is_at_least(50).on(:create) }
  it { is_expected.to validate_length_of(:short_description).is_at_most(900).on(:create) }
  it { is_expected.to validate_inclusion_of(:number_of_people).in_array((1..5).map(&:to_s)) }
  it { is_expected.to validate_inclusion_of(:difficulty).in_array((1..5).map(&:to_s)) }
  # it { is_expected.to validate_format_of(:title).with(/[[:alpha:]]/) }
end
