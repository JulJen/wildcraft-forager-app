class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :team_id

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
