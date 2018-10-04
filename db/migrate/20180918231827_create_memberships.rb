class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.boolean :admin, default: false
      t.integer :user_id
      t.integer :project_id

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
