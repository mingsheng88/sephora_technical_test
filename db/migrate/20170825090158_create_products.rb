class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :category, array: true, default: []
      t.integer :stock_status, default: 0, null: false
      t.monetize :price
      t.monetize :sale_price
      t.integer :sale_status, default: 0, null: false
      t.string :sale_text

      t.timestamps
    end
  end
end
