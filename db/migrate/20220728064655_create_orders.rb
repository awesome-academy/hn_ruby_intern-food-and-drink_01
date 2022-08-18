class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone_num
      t.string :address
      t.text :note
      t.integer :status, default: 0
      t.text :reason
      t.decimal :total_money, default: 0, precision: 10, scale: 2

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
