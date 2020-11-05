RSpec.describe Games::IndexQuery do
  subject(:query) { described_class.new(params) }

  let(:params) { { sort: sort } }

  before { create_list(:game, 3, :with_statistic) }

  describe '#call' do
    describe 'successful sorting' do
      shared_examples 'proper sorting' do
        it { expect(query.call).to eq(Game.left_joins(:statistics).order(Arel.sql(sort))) }
      end

      context 'with sorting by statistics.current_players asc' do
        let(:sort) { 'statistics.current_players' }

        include_examples 'proper sorting'
      end

      context 'with sorting by statistics.current_players desc' do
        let(:sort) { '-statistics.current_players' }

        include_examples 'proper sorting'
      end

      context 'with sorting by statistics.peak_today asc' do
        let(:sort) { 'statistics.peak_today' }

        include_examples 'proper sorting'
      end

      context 'with sorting by statistics.peak_today desc' do
        let(:sort) { '-statistics.peak_today' }

        include_examples 'proper sorting'
      end
    end

    describe 'failure sorting' do
      let(:sort) { 'wrong_column' }

      it { expect(query.call).to eq(Game.left_joins(:statistics)) }
    end
  end
end
