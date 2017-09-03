describe Product, type: :model do
  context 'scopes' do
    describe 'in_category' do
      it 'finds products given 1 category' do
        cat_one, cat_two = create_list(:category, 2)
        product = create(:product, categories: [cat_one, cat_two])
        uncategorized_product = create(:product, categories: [])

        in_cat_one = described_class.in_category(cat_one.name)
        in_cat_two = described_class.in_category(cat_two.name)
        no_cat_given = described_class.in_category('non-existent')

        expect(in_cat_one).to include(product)
        expect(in_cat_one).not_to include(uncategorized_product)

        expect(in_cat_two).to include(product)
        expect(in_cat_two).not_to include(uncategorized_product)

        expect(no_cat_given).not_to include(product)
        expect(no_cat_given).not_to include(uncategorized_product)
      end

      it 'finds products given >1 categories' do
        cat_one, cat_two, cat_three = create_list(:category, 3)
        product = create(:product, categories: [cat_one])
        product_two = create(:product, categories: [cat_one])
        product_three = create(:product, categories: [cat_two])

        search_result = described_class.in_category(cat_two.name, cat_three.name)

        expect(search_result).not_to include(product)
        expect(search_result).not_to include(product_two)
        expect(search_result).to include(product_three)
      end

      it 'finds all given empty string' do
        product = create(:product, :with_categories)
        uncategorized_product = create(:product)

        expect(described_class.in_category('')).to include(product)
        expect(described_class.in_category('')).to include(uncategorized_product)
      end
    end

    describe 'in_categories' do
      it 'calls in_category' do
        input = ['cat_one', 'cat_two']

        expect(described_class).to receive(:in_category).with(input)

        described_class.in_categories(input)
      end
    end

    describe 'price_range' do
      it 'finds all products in range given from and to' do
        product = create(:product, price: 1)
        product_two = create(:product, price: 2)
        product_three = create(:product, price: 3)

        search_result = described_class.price_range(from: 2, to: 3)

        expect(search_result).not_to include(product)
        expect(search_result).to include(product_two, product_three)
      end

      it 'finds all products given from' do
        product = create(:product, price: 1)
        product_two = create(:product, price: 2)
        product_three = create(:product, price: 3)

        search_result = described_class.price_range(from: 2)

        expect(search_result).not_to include(product)
        expect(search_result).to include(product_two, product_three)
      end

      it 'finds all products given from taking into consideration sale_price' do
        product = create(:product, price: 1)
        product_two = create(:product,
                             price: 5,
                             sale_status: described_class::sale_statuses[:on_sale],
                             sale_price: 2)
        product_three = create(:product, price: 3)

        search_result = described_class.price_range(from: 2)

        expect(search_result).not_to include(product)
        expect(search_result).to include(product_two, product_three)
      end

      it 'finds all products given to' do
        product = create(:product, price: 1)
        product_two = create(:product, price: 2)
        product_three = create(:product, price: 3)

        search_result = described_class.price_range(to: 2)

        expect(search_result).to include(product, product_two)
        expect(search_result).not_to include(product_three)
      end

      it 'finds all products given to taking into consideration sale_price' do
        product = create(:product, price: 1)
        product_two = create(:product,
                             price: 4,
                             sale_status: described_class::sale_statuses[:on_sale],
                             sale_price: 2)
        product_three = create(:product, price: 3)

        search_result = described_class.price_range(to: 2)

        expect(search_result).to include(product, product_two)
        expect(search_result).not_to include(product_three)
      end

      it 'finds all products by default' do
        product = create(:product, price: 1)
        product_two = create(:product, price: 2)
        product_three = create(:product, price: 3)

        search_result = described_class.price_range

        expect(search_result).to include(product, product_two, product_three)
      end
    end

    # TODO: Quite a few more cases to consider, i.e. deletion
    describe 'expanding categories assocation' do
      it 'breaks down associations' do
        one = create(:category)
        two = create(:category, parent: one)
        three = create(:category, parent: two)
        product = create(:product)
        product.categories << three
        expect(product.categories.size).to eq(3)
      end
    end
  end
end
