class ChangePasswordConfirmation < ActiveRecord::Migration
  def change
    rename_column :users, :confirm_password, :password_confirmation
  end
end
