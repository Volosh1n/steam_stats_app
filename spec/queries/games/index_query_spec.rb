RSpec.describe Games::IndexQuery do
  subject(:query) { described_class.new(params) }

  let(:params) { { sort: sort } }
  let(:sort) { '' }

  describe '#call' do
    describe 'sorting' do
      before { create_list(:game, 3, :with_statistic) }

      describe 'successful' do
        shared_examples 'proper sorting' do
          it { expect(query.call.ids).to eq Game.left_joins(:statistics).order(Arel.sql(sort)).ids }
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

      describe 'failure' do
        let(:sort) { 'wrong_column' }

        it { expect(query.call.ids).to eq(Game.left_joins(:statistics).ids) }
      end
    end

    describe 'ranks' do
      describe 'current_online_rank' do
        let!(:most_successful_by_current_online_game) { create(:statistic, current_players: 3).game }
        let!(:average_successful_by_current_online_game) { create(:statistic, current_players: 2).game }
        let!(:least_successful_by_current_online_game) { create(:statistic, current_players: 1).game }
        let(:sort) { '-statistics.current_players' }

        it 'adds proper rank values to all games' do
          expect(query.call.first.current_online_rank).to eq(1)
          expect(query.call.second.current_online_rank).to eq(2)
          expect(query.call.third.current_online_rank).to eq(3)
        end
      end

      describe 'peak_online_rank' do
        let!(:most_successful_by_peak_online_game) { create(:statistic, peak_today: 3).game }
        let!(:average_successful_by_peak_online_game) { create(:statistic, peak_today: 2).game }
        let!(:least_successful_by_peak_online_game) { create(:statistic, peak_today: 1).game }
        let(:sort) { '-statistics.peak_today' }

        it 'adds proper rank values to all games' do
          expect(query.call.first.peak_online_rank).to eq(1)
          expect(query.call.second.peak_online_rank).to eq(2)
          expect(query.call.third.peak_online_rank).to eq(3)
        end
      end
    end
  end
end
