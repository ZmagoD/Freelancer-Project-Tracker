require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
