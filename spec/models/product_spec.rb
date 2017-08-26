describe Product, type: :model do
  context 'scopes' do
    describe 'in_category' do
      it 'scopes out products in the correct category given 1 category' do
        product = create(:product, categories: ['cat_one', 'cat_two'])
        uncategorized_product = create(:product, categories: [])

        expect(described_class.in_category('cat_one')).to include(product)
        expect(described_class.in_category('cat_one')).not_to include(uncategorized_product)

        expect(described_class.in_category('cat_two')).to include(product)
        expect(described_class.in_category('cat_two')).not_to include(uncategorized_product)

        expect(described_class.in_category('not_found')).not_to include(product)
        expect(described_class.in_category('not_found')).not_to include(uncategorized_product)
      end

      it 'scopes out products in the correct category given 2 categories' do
        product = create(:product, categories: ['cat_one', 'cat_two'])
        product_two = create(:product, categories: ['cat_one', 'cat_three'])
        product_three = create(:product, categories: ['cat_one', 'cat_two', 'cat_three'])

        search_result = described_class.in_category(['cat_one', 'cat_three'])

        expect(search_result).not_to include(product)
        expect(search_result).to include(product_two)
        expect(search_result).to include(product_three)
      end

      it 'returns everything if empty string is provided' do
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
  end
end
