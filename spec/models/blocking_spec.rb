require 'rails_helper'

RSpec.describe Blocking, type: :model do
  it { is_expected.to belong_to(:user) }
end
