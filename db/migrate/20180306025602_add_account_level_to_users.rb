class AddAccountLevelToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :account_level, :integer
    add_column :users, :expiration_date, :integer
  end
end
