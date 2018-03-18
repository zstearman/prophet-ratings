class ChangeConferenceLossesToInteger < ActiveRecord::Migration[5.1]
  def change
    remove_column :team_seasons, :conference_losses
    remove_column :team_seasons, :possessions
    remove_column :team_seasons, :integer
    add_column :team_seasons, :conference_losses, :integer
    add_column :team_seasons, :possessions, :integer
  end
end
