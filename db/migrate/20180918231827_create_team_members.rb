class CreateTeamMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :email
      t.integer :user_id
      t.integer :team_id
      t.integer :project_id
      t.text :image

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
