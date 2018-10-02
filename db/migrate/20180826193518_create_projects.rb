class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.boolean :status, default: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.timestamps
    end
  end
end
