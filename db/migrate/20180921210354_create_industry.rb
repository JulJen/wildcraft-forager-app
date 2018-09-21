class CreateIndustry < ActiveRecord::Migration[5.2]
  def change
    create_table :industries do |t|
      t.string :category
      t.string :profession

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
