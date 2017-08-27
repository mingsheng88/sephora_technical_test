class Api::V1::ProductResource < JSONAPI::Resource
  attribute :id
  attribute :price
  attribute :categories

  filter :categories,
    default: '',
    apply: ->(records, values, _options) {
      records.in_categories(values)
    }
end
