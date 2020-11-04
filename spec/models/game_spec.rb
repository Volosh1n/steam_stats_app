RSpec.describe Game, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:statistics).dependent(:destroy) }
  end
end
