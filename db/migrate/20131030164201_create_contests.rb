class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.datetime :deadline
      t.datetime :start
      t.text :description
      t.string :name
      t.string :contest_type

      t.timestamps
    end
  end
end
