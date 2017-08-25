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
end
