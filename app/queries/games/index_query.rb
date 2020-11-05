module Games
  class IndexQuery
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      games
        .yield_self(&method(:sort_clause))
        .yield_self(&method(:rank_clause))
    end

    private

    attr_reader :params

    def games
      @games ||= Game.includes(:statistics).left_joins(:statistics)
    end

    def sort_clause(relation)
      return relation.order(Arel.sql('-statistics.current_players')) unless params[:sort]

      case params[:sort]
      when *valid_sorting then relation.order(Arel.sql(params[:sort]))
      else relation
      end
    end

    def valid_sorting
      %w[
        statistics.current_players
        -statistics.current_players
        statistics.peak_today
        -statistics.peak_today
      ]
    end

    def rank_clause(relation)
      relation.select(
        'games.*',
        'rank() OVER (ORDER BY statistics.current_players DESC) AS current_online_rank',
        'rank() OVER (ORDER BY statistics.peak_today DESC) AS peak_online_rank'
      )
    end
  end
end
