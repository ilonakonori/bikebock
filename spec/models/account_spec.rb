require 'rails_helper'

RSpec.describe Account, type: :model do
  # relations
  it { is_expected.to belong_to(:user) }
  # validations
  it { is_expected.to validate_presence_of(:theme) }
  it { is_expected.to validate_inclusion_of(:theme).in_array(%w(light-mode dark-mode)) }
end
