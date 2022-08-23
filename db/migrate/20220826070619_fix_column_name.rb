class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :product_sizes, :coefficient, :price
  end
end
