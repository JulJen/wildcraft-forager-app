class AddUserInfoToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :language, :string
    add_column :users, :gender, :string
    add_column :users, :programlanguage, :string
    add_column :users, :interest, :string
  end
end
