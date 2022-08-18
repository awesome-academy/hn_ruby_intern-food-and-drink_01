class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.decimal :price, precision: 10, scale: 2
      t.integer :num
      t.decimal :total_money, precision: 10, scale: 2

      t.references :order, null: false, foreign_key: true
      t.references :product_size, null: false, foreign_key: true

      t.timestamps
    end
  end
end
