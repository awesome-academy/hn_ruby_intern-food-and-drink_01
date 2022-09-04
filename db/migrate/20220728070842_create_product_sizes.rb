class CreateProductSizes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_sizes do |t|
      t.float :coefficient

      t.references :product, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true

      t.timestamps
    end
  end
end
