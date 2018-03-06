class DropExpirationDateFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :expiration_date, :integer
  end
end
