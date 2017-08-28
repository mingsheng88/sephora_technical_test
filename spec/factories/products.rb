FactoryGirl.define do
  factory :product do
    price { rand(0.0..100.0) }
    sale_price { rand(0.0..100.0)}
    brand
  end
end
