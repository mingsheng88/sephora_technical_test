class RemoveColumnCategoriesFromProducts < ActiveRecord::Migration[5.1]
  def up
    remove_column :products, :categories
  end

  def down
    add_column :products, :categories, :string, array: true, default: []
  end
end
