class AddTeamMemberInfoToTeamMember < ActiveRecord::Migration[5.2]
  def change
    add_column :team_members, :time_zone, :string
    add_column :team_members, :language, :string
    add_column :team_members, :gender, :string
    add_column :team_members, :programlanguage, :string
    add_column :team_members, :interest, :string
  end
end
