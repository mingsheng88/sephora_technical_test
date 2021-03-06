# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command
# or created alongside the database with db:setup.
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)

FactoryGirl.create_list(:category, 20)
10.times do
  FactoryGirl.create_list(:product, rand(0..10), :named, categories: Category.all.sample(2))
end
5.times do
  FactoryGirl.create_list(:product, rand(0..10), :named, :out_of_stock, categories: Category.all.sample(2))
end
5.times do
  FactoryGirl.create_list(:product, rand(0..10), :named, :on_sale, categories: Category.all.sample(2))
end
