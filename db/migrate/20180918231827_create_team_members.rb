class CreateTeamMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :team_members do |t|
      t.integer :user_id
      t.integer :project_id

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
