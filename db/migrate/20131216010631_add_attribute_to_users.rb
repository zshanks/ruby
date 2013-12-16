class AddAttributeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banned, :boolean, default: false 
    add_column :users, :contest_creator, :boolean, default: false
    add_column :users, :password_digest, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :remember_token, :string
  end
end
