FactoryGirl.define do
  factory :product do
    price { rand(0.0..100.0) }
    brand

    transient do
      num_categories 0
    end

    trait :with_category do
      num_categories 1
    end
    trait :with_categories do
      num_categories 2
    end

    trait :named do
      name { FFaker::Product.product }
    end

    trait :out_of_stock do
      stock_status { Product::stock_statuses[:out_of_stock] }
    end

    trait :on_sale do
      sale_status { Product::sale_statuses[:on_sale] }
      sale_price { rand(0.0..100.0)}
    end

    after(:create) do |product, evaluator|
      product.categories << create_list(:category, evaluator.num_categories)
    end
  end
end
