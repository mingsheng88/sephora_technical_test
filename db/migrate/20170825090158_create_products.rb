class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :category, array: true, default: []
      t.integer :stock_status, default: 0, null: false
      t.monetize :price

      # FIXME: For consideration, instead of these 3 fields, a better approach may be to:
      # - separate model for sale
      # - instead of sale price, go for value, with sale types, i.e. discount%, discount$ etc
      # - instead of sale status, go for sale start date, sale end date
      # - instead of sale text, generate text in helper class based on sale status
      t.monetize :sale_price
      t.integer :sale_status, default: 0, null: false
      t.string :sale_text

      t.timestamps
    end
  end
end
