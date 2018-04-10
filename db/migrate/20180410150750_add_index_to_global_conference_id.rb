class AddIndexToGlobalConferenceId < ActiveRecord::Migration[5.1]
  def change
    add_index :conferences, :global_conference_id
  end
end
