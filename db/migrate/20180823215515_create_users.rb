class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :password_digest
      t.string :email
      t.text :image
      t.string :time_zone
      t.string :language, :string
      t.string :gender, :string
      t.string :programlanguage, :string
      t.string :interest

      t.boolean :team_admin, default: false
      t.boolean :status, default: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.timestamps
    end
  end
end
