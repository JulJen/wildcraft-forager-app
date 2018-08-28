class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.text :user_comments
      t.integer :team_id


      t.timestamps
    end
  end
end
