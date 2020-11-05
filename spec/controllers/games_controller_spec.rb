RSpec.describe GamesController, type: :controller do
  describe 'GET #index' do
    it 'responds index with success status' do
      get :index
      expect(response).to render_template(:index)
      expect(response.status).to eq(200)
    end

    it 'calls Games::IndexQuery' do
      expect(Games::IndexQuery).to receive(:call)
      get :index
    end
  end
end
