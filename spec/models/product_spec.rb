describe Product, type: :model do
  context 'scopes' do
    describe 'in_category' do
      it 'finds products given 1 category' do
        product = create(:product, categories: ['cat_one', 'cat_two'])
        uncategorized_product = create(:product, categories: [])

        expect(described_class.in_category('cat_one')).to include(product)
        expect(described_class.in_category('cat_one')).not_to include(uncategorized_product)

        expect(described_class.in_category('cat_two')).to include(product)
        expect(described_class.in_category('cat_two')).not_to include(uncategorized_product)

        expect(described_class.in_category('not_found')).not_to include(product)
        expect(described_class.in_category('not_found')).not_to include(uncategorized_product)
      end

      it 'finds products given >1 categories' do
        product = create(:product, categories: ['cat_one', 'cat_two'])
        product_two = create(:product, categories: ['cat_one', 'cat_three'])
        product_three = create(:product, categories: ['cat_one', 'cat_two', 'cat_three'])

        search_result = described_class.in_category(['cat_one', 'cat_three'])

        expect(search_result).not_to include(product)
        expect(search_result).to include(product_two)
        expect(search_result).to include(product_three)
      end

      it 'finds all given empty string' do
        product = create(:product, categories: ['cat_one', 'cat_two'])
        uncategorized_product = create(:product, categories: [])

        expect(described_class.in_category('')).to include(product)
        expect(described_class.in_category('')).to include(uncategorized_product)
      end

      it 'is not sequence sensitive' do
        product = create(:product, categories: ['cat_one', 'cat_two'])
        product_two = create(:product, categories: ['cat_two', 'cat_one'])

        search_result = described_class.in_category(['cat_one', 'cat_two'])

        expect(search_result).to include(product)
        expect(search_result).to include(product_two)
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

      it 'finds all products given to' do
        product = create(:product, price: 1)
        product_two = create(:product, price: 2)
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
  end
end
