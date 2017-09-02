class Api::V1::CategoryResource < JSONAPI::Resource
  attribute :name
  attribute :children

  def children
    @model.children.map(&:name)
  end

  def self.records(options = {})
    Category.roots
  end
end
