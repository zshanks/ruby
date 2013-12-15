class AddChaturlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chat_url, :string
  end
end
