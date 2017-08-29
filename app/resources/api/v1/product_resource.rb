class Api::V1::ProductResource < JSONAPI::Resource
  default_page_size = 20

  attributes :name, :price, :categories, :stock_status, :sale_status
  attribute :brand_name

  belongs_to :brand

  def brand_name
    brand.name
  end

  filter :categories,
    default: '',
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
