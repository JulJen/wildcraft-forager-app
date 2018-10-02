class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :user_id
      t.integer :post_id
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
