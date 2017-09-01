FactoryGirl.define do
  factory :category do
    name { FFaker::Music.genre }

    trait :with_children do
      parent_id { create(:category).id }
    end
  end
end
