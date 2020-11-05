class GamesController < ApplicationController
  def index
    @games = Games::IndexQuery.call(params)
  end
end
