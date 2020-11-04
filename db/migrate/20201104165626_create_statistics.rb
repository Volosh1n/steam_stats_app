class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.integer :current_players
      t.integer :peak_today
      t.belongs_to :game, foreign_key: true, index: true

      t.timestamps
    end
  end
end
