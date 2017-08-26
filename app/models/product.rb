class Product < ApplicationRecord
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }
  monetize :sale_price_cents, numericality: { greater_than_or_equal_to: 0 }

  enum stock_status: {
    in_stock: 0,
    out_of_stock: 1
  }

  enum sale_status: {
    not_on_sale: 0,
    on_sale: 1
  }

  scope :in_category, ->(*category_names) {
    if category_names.blank?
      all
    else
      where('products.categories @> ?', "{#{category_names.join(',')}}")
    end
  }
  scope :in_categories, ->(*category_names) { in_category(*category_names) }
end
