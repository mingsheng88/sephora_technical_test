class Api::V1::ProductResource < JSONAPI::Resource
  DEFAULT_PAGE_SIZE = default_page_size = 20

  attributes :name, :stock_status, :sale_status, :sale_text
  attributes :price, :sale_price, format: :money
  attributes :brand_name, :category_names

  has_one :brand
  has_many :categories

  def brand_name
    brand.name
  end

  def category_names
    categories.map(&:name)
  end

  filter :category_names,
    default: '',
    verify: ->(values, _context) { values },
    apply: ->(records, values, _options) { records.in_categories(values) }

  filter :price_from,
    verify: ->(values, _context) { values.map { |value| BigDecimal(value) } },
    apply: ->(records, values, _options) { records.price_range(from: values[0]) }

  filter :price_to,
    verify: ->(values, _context) { values.map { |value| BigDecimal(value) } },
    apply: ->(records, values, _options) { records.price_range(to: values[0]) }

  def self.apply_sort(records, order_options, context = {})
    order_options = order_options.with_indifferent_access

    if order_options.include?(:price)
      records = records.order(price_cents: order_options[:price])
      order_options.delete(:price)
    end
    super(records, order_options, context)
  end
end
