class AddExpirationDateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :expiration_date, :date
  end
end
