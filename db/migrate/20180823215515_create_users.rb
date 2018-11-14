class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :password_digest
      t.string :email
      t.text :image

      t.string :city
      t.string :us_state
      t.string :time_zone
      t.string :country_code

      t.string :gender
      t.string :interest
      t.boolean :status, default: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.timestamps
    end
  end
end
