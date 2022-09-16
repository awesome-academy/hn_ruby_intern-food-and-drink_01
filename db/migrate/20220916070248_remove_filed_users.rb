class RemoveFiledUsers < ActiveRecord::Migration[6.1]
  def self.up
    remove_column :users, :password_digest
  end

  def self.down
    add_column :users, :password_digest, :string
  end
end
