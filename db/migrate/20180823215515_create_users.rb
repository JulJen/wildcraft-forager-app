class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :password_digest
      t.string :email
      t.text :image
      t.string :time_zone
      t.boolean :status, default: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.timestamps
    end
  end
end
