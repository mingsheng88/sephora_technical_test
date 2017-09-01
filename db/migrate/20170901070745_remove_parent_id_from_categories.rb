class RemoveParentIdFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :parent_id, :integer
  end
end
