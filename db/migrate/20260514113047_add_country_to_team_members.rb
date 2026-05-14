class AddCountryToTeamMembers < ActiveRecord::Migration[8.1]
  def change
    add_column :team_members, :country, :string
  end
end
