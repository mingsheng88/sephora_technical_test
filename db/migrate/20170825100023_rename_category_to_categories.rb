class RenameCategoryToCategories < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :category, :categories
  end
end
