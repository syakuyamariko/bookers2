class AddUserIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_id, :integer
    add_index :users, :name, unique: true #名前の一意性制約
  end
end
