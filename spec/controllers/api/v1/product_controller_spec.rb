describe Api::V1::ProductsController, type: :controller do
  describe 'GET api/v1/products' do
    it 'returns all products' do
      product, product_two = create_list(:product, 2)
      get :index
      expect(json.dig(:data, 0, :id)).to eq(product.id.to_s)
      expect(json.dig(:data, 1, :id)).to eq(product_two.id.to_s)
    end

    context 'filtering' do
      context 'categories' do
        it 'filters by categories' do
          product_one = create(:product, categories: ['cat', 'cat_one'])
          product_two = create(:product, categories: ['cat', 'cat_two'])
          get :index, params: { filter: { categories: 'cat_one' } }
          expect(json.dig(:data).size).to eq(1)
          expect(json.dig(:data, 0, :id)).to eq(product_one.id.to_s)
        end

        it 'filters by categories' do
          product_one = create(:product, categories: ['cat', 'cat_one'])
          product_two = create(:product, categories: ['cat', 'cat_two'])
          get :index, params: { filter: { categories: 'cat' } }
          expect(json.dig(:data).size).to eq(2)
        end

        it 'filters by categories' do
          product_one = create(:product, categories: ['cat', 'cat_one'])
          product_two = create(:product, categories: ['cat', 'cat_two'])
          get :index, params: { filter: { categories: 'NON_EXISTENT' } }
          expect(json.dig(:data).size).to eq(0)
        end
      end

      context 'price' do
        it 'filters by price_to' do
          product_one = create(:product, price: 12)
          product_two = create(:product, price: 15)
          get :index, params: { filter: { price_to: 13 } }
          expect(json.dig(:data).size).to eq(1)
          expect(json.dig(:data, 0, :id)).to eq(product_one.id.to_s)
        end

        it 'filters by price_from' do
          product_one = create(:product, price: 12)
          product_two = create(:product, price: 15)
          get :index, params: { filter: { price_from: 13 } }
          expect(json.dig(:data).size).to eq(1)
          expect(json.dig(:data, 0, :id)).to eq(product_two.id.to_s)
        end

        it 'filters by price_from and price_to' do
          product_one = create(:product, price: 12)
          product_two = create(:product, price: 15)
          product_three = create(:product, price: 18)
          get :index, params: { filter: { price_from: 13, price_to: 16 } }
          expect(json.dig(:data).size).to eq(1)
          expect(json.dig(:data, 0, :id)).to eq(product_two.id.to_s)
        end
      end
    end

    context 'sorting' do
      it 'sorts by price desc' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { sort: '-price' }
        expect(json[:data].map { |x| x[:id] }.map(&:to_i)).
          to eq([product_three, product_one, product_two].map(&:id))
      end

      it 'sorts by price asc' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { sort: 'price' }
        expect(json[:data].map { |x| x[:id] }.map(&:to_i)).
          to eq([product_two, product_one, product_three].map(&:id))
      end
    end
  end

  context 'GET api/v1/product/:product_id' do
    it 'returns a specified product' do
      product, product_two = create_list(:product, 2)
      get :show, params: { id: product }
      expect(json.dig(:data, :id)).to eq(product.id.to_s)
    end
  end
end
