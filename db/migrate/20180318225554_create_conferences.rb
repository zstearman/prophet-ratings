class CreateConferences < ActiveRecord::Migration[5.1]
  def change
    create_table :conferences do |t|
      t.string :name, index: true
      t.string :key

      t.timestamps
    end
    
    add_reference :teams, :conference, index: true
  end
end
