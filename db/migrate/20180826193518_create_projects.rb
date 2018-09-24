class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.text :task_id
      t.integer :team_id
      t.boolean :status, default: true

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.timestamps
    end
  end
end
