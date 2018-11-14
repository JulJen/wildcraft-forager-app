class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.boolean :status, default: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.timestamps
    end
  end
end
