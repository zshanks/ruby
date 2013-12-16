class AddAttributeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :downloadable, :boolean, default: false 
    add_column :players, :playable, :boolean, default: true 
  end
end
