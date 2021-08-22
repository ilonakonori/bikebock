require 'rails_helper'

RSpec.describe Request, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:ride) }
  it { is_expected.to validate_presence_of(:ride_date) }
  it { is_expected.to validate_presence_of(:ride_id) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:recipient_id) }
end
