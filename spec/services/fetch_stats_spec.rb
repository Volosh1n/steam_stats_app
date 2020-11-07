RSpec.describe FetchStats do
  subject(:service) { described_class.new }

  let(:stubbed_stats_html) { File.open(Rails.root.join('spec/fixtures/stats.html')) }

  before { allow(URI).to receive(:open).and_return(stubbed_stats_html) }

  describe '#call' do
    it 'returns hash' do
      expect(described_class.call).to be_a Hash
    end

    it 'creates game for each key of returned hash' do
      expect { service.call }.to change(Game, :count).from(0).to(100)
    end

    it 'creates game statistic for each value of returned hash' do
      expect { service.call }.to change(Statistic, :count).from(0).to(100)
    end

    context 'when some games already exists in DB' do
      before { create(:game, :with_statistic, name: 'Among Us') }

      it 'does not recreate the same game' do
        expect { service.call }.to change(Game, :count).from(1).to(100)
      end

      it 'fetches game statistic for already existing game anyway' do
        expect { service.call }.to change(Statistic, :count).from(1).to(101)
      end
    end
  end
end
