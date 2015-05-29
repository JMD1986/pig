class LeaderBoard < ActiveRecord::Migration
  def change
    create_table :leaderboards do |t|
      t.string   :name
      t.integer  :games_won
      t.integer  :games_lost

    end
  end
end

