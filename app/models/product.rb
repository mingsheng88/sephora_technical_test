class Product < ApplicationRecord
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }
  monetize :sale_price_cents, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :brand
  has_and_belongs_to_many :categories

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
    query = query.where('products.price_cents >= ?', from * 100) if from
    query = query.where('products.price_cents <= ?', to * 100) if to
    query
  }

  before_save :expand_categories_tree

  def expand_categories_tree
  end
end
