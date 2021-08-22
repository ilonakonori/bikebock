require 'rails_helper'

RSpec.describe Booking, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:ride) }
  it { is_expected.to have_one(:review) }
end
