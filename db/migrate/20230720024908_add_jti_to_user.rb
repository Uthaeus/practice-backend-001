class AddJtiToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :jti, :string, null: false, default: ""
    add_index :users, :jti, unique: true
    add_column :users, :role, :string, null: false, default: "user"
  end
end
