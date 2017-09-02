require 'rspec/expectations'

RSpec::Matchers.define :contain_resource_count_of do |count|
  match do |json|
    return unless json[:data]
    json.dig(:data).try(:size) === count
  end

  description do
    "have exactly #{count} resources"
  end
end

RSpec::Matchers.define :contain_resource_ids do |expected_ids|
  match do |json|
    return unless json[:data]
    @sorted_ids = expected_ids.sort
    id_values(json).sort === @sorted_ids
  end

  description do
    "contain values #{@sorted_ids}"
  end
end

RSpec::Matchers.define :contain_resources do |expected_resources|
  match do |json|
    return unless json[:data]
    @sorted_ids = expected_resources.map(&:id).sort
    id_values(json).sort === @sorted_ids
  end

  description do
    "contain values #{@sorted_ids}"
  end
end

RSpec::Matchers.define :match_resources do |expected_resources|
  match do |json|
    return unless json[:data]
    @ids = expected_resources.map(&:id)
    id_values(json) === @ids
  end

  description do
    "contain resources of id #{@ids}"
  end
end

RSpec::Matchers.define :match_resource do |expected_resource|
  match do |json|
    return unless json[:data]
    json.dig(:data, :id).try(:to_i) === expected_resource.id
  end

  description do
    "match resource #{expected_resource.id}"
  end
end

RSpec::Matchers.define :have_page_count do |expected_count|
  match do |json|
    page_count(json) === expected_count
  end

  description do
    "contain #{expected_count.to_s} page(s) but found #{page_count(json)} page(s)"
  end
end

def page_count(json)
  @_page_count ||= (json[:meta] && json[:meta][:page_count])
end

def id_values(json)
  @_id_values ||= json[:data].map { |x| x[:id].to_i }
end
