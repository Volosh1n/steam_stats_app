RSpec.describe Statistic, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:game) }
  end
end
