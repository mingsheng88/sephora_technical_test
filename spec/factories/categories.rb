FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "#{FFaker::Music.genre} #{n}" }

    trait :with_children do
      parent_id { create(:category).id }
    end
  end
end
