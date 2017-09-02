class Api::V1::CategoryResource < JSONAPI::Resource
  attributes :name, :slug
  attribute :children

  def children
    @model.children.map do |child|
      { name: child.name, slug: child.slug }
    end
  end

  def self.records(options = {})
    Category.roots
  end
end
