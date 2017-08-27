class Api::V1::ProductResource < JSONAPI::Resource
  attribute :id
  attribute :price
  attribute :categories

  filter :categories,
    default: '',
    apply: ->(records, values, _options) { records.in_categories(values) }

  filter :price_from,
    verify: ->(values, _context) { values.map { |value| BigDecimal(value) } },
    apply: ->(records, values, _options) { records.price_range(from: values[0]) }

  filter :price_to,
    verify: ->(values, _context) { values.map { |value| BigDecimal(value) } },
    apply: ->(records, values, _options) { records.price_range(to: values[0]) }
end
