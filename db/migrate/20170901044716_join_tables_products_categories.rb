class JoinTablesProductsCategories < ActiveRecord::Migration[5.1]
  def change
    create_join_table :products, :categories
  end
end
