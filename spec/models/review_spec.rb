require 'rails_helper'

RSpec.describe Review, type: :model do
  it { is_expected.to belong_to(:booking) }
  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_inclusion_of(:rating).in_array((1..5).to_a).with_low_message("please give a rating of 1-5") }
end