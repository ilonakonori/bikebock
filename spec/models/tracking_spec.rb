require 'rails_helper'

RSpec.describe Tracking, type: :model do
  it { is_expected.to belong_to(:user) }
end
