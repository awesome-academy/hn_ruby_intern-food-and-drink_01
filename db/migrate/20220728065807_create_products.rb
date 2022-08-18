class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :unit_price, precision: 10, scale: 2
      t.string :image
      t.text :description

      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
