# :nocov:
namespace :games do
  namespace :stats do
    desc 'Fetch game stats'
    task fetch: :environment do
      LINK = 'https://store.steampowered.com/stats/'.freeze
      STATS_ROWS_CLASS = '.player_count_row'.freeze

      doc = Nokogiri::HTML(URI.open(LINK), &:noblanks)

      stats = doc.css(STATS_ROWS_CLASS).map do |game_stats|
        cells = game_stats.css('td')
        [
          cells.css('a').text,
          {
            current_players: cells.shift.css('span').text,
            peak_today: cells.css('span').text
          }
        ]
      end

      stats.to_h.each do |game_name, stats|
        game = Game.find_or_create_by(name: game_name)
        game.statistics.create(stats)
      end
    end
  end
end
# :nocov:
