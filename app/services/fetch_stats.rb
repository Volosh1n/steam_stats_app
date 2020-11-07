require 'open-uri'

class FetchStats
  LINK = 'https://store.steampowered.com/stats/'.freeze
  STATS_ROWS_CLASS = '.player_count_row'.freeze

  def self.call
    new.call
  end

  def call
    all_stats.each do |game_name, stats|
      game = Game.find_or_create_by(name: game_name)
      game.statistics.create(stats)
    end
  end

  private

  def doc
    Nokogiri::HTML(URI.open(LINK), &:noblanks)
  end

  def all_stats
    doc.css(STATS_ROWS_CLASS).map do |game_stats|
      cells = game_stats.css('td')
      [
        cells.css('a').text,
        {
          current_players: cells.shift.css('span').text.delete(',').to_i,
          peak_today: cells.css('span').text.delete(',').to_i
        }
      ]
    end.to_h
  end
end
