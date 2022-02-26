require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it "is valid with name, email, password, photos.." do
    expect(user).to be_valid
  end

  it 'creates account after sign up' do
    expect(user.account).to_not be_nil
  end

  it 'creates tracking after sign up' do
    expect(user.tracking).to_not be_nil
  end

  it 'creates tags after sign up' do
    expect(user.tag_list).to_not be_nil
  end

  # relations
  it { is_expected.to have_many :rides }
  it { is_expected.to have_many :notifications }
  it { is_expected.to have_many :requests }
  it { is_expected.to have_many :bookings }
  it { is_expected.to have_many :blockings }
  it { is_expected.to have_one :tracking }
  it { is_expected.to have_one :account }
  # attached files
  it { is_expected.to have_one_attached :profile_photo }
  it { is_expected.to have_one_attached :bike_photo }
  # validations
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_presence_of :interests }
  it { is_expected.to validate_presence_of :profile_photo }
  # it { is_expected.to validate_uniqueness_of :name }
  # it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_length_of(:name).is_at_least(2).on(:create) }
  it { is_expected.to validate_length_of(:name).is_at_most(20).on(:create) }
  it { is_expected.to validate_length_of(:password).is_at_least(8).on(:create) }
  it { is_expected.to validate_length_of(:password).is_at_most(128).on(:create) }
  it { is_expected.to validate_length_of(:interests).is_at_least(10).on(:create) }
  it { is_expected.to validate_length_of(:interests).is_at_most(200).on(:create) }
  # it { is_expected.to validate_format_of(:name).with(/[a-zA-Z0-9_]/) }
end
