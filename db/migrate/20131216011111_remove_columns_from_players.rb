class RemoveColumnsFromPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :downloadable
    remove_column :players, :playable
  end
end
