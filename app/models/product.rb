class Product < ApplicationRecord
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }
  monetize :sale_price_cents, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :brand
  has_and_belongs_to_many :categories,
    after_add: :expand_categories_tree,
    after_remove: :delete_unused_categories

  enum stock_status: {
    in_stock: 0,
    out_of_stock: 1
  }

  enum sale_status: {
    not_on_sale: 0,
    on_sale: 1
  }

  scope :in_category, ->(*category_names) {
    category_names.reject!(&:blank?)
    category_names.flatten!
    if category_names.blank?
      all
    else
      joins(:categories).
        includes(:categories).
        where('categories.name similar to ?', "%(#{category_names.join('|')})%")
    end
  }
  scope :in_categories, ->(*category_names) { in_category(*category_names) }
  scope :price_range, ->(from: nil, to: nil) {
    query = all
    if from
      query = query.
        where(
          "(products.sale_status = ? AND products.price_cents >= ?)" \
          " or " \
          "(products.sale_status = ? AND products.sale_price_cents >= ?)",
          sale_statuses[:not_on_sale], from * 100,
          sale_statuses[:on_sale], from * 100)
    end
    if to
      query = query.
        where(
          "(products.sale_status = ? AND products.price_cents <= ?)" \
          " or " \
          "(products.sale_status = ? AND products.sale_price_cents <= ?)",
          sale_statuses[:not_on_sale], to * 100,
          sale_statuses[:on_sale], to * 100)
    end
    query
  }

  def expand_categories_tree(added_category)
    return unless persisted?
    ancestor_ids = added_category.ancestor_ids
    categories << Category.where(id: ancestor_ids - categories.pluck(:id))
  end

  def delete_unused_categories(removed_category)
    removed_category.ancestors.reverse.each do |ancestor|
      return if (categories & ancestor.children).any?
      categories.destroy(ancestor)
    end
  end
end
