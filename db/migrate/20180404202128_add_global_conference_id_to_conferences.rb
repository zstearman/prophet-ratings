class AddGlobalConferenceIdToConferences < ActiveRecord::Migration[5.1]
  def change
    add_column :conferences, :global_conference_id, :integer, index: true
  end
end
