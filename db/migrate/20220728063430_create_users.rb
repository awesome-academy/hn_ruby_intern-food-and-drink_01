class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, index: {unique: true}
      t.string :phone_num, index: {unique: true}
      t.string :address
      t.string :password_digest
      t.integer :role, default: 1

      t.timestamps
    end
  end
end
