class MoneyValueFormatter < JSONAPI::ValueFormatter
  def self.format(raw_value)
    super(raw_value).to_f
  end
end
