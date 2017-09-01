describe Api::V1::ProductsController, type: :controller do
  describe 'GET api/v1/products' do
    it 'returns all products' do
      product, product_two = create_list(:product, 2, :with_category)
      get :index
      expect(json.dig(:data, 0, :id)).to eq(product.id.to_s)
      expect(json.dig(:data, 1, :id)).to eq(product_two.id.to_s)
    end

    it 'integrates all filtering, sorting, and paginating' do
      cat_one = create(:category, name: 'one')
      cat_two = create(:category, name: 'two')

      uncategorized_product = create(:product, price: 12)
      overpriced_product = create(:product, categories: [cat_one, cat_two], price: 15)

      expected_product_one = create(:product, categories: [cat_one, cat_two], price: 10)
      expected_product_two = create(:product, categories: [cat_one, cat_two], price: 11)
      expected_product_three = create(:product, categories: [cat_one, cat_two], price: 12)

      get :index, params: {
        filter: { category_names: ['one','two'], price_from: 10, price_to: 12 },
        sort: '-price',
        page: { number: 3, size: 1 }
      }

      expect(json.dig(:data).size).to eq(1)
      expect(json.dig(:data, 0, :id)).to eq(expected_product_one.id.to_s)
      expect(json.dig(:meta, :page_count)).to eq(3)
    end

    context 'filtering' do
      context 'categories' do
        it 'filters by categories' do
          expected_category = create(:category, name: 'Expected Category' )
          product_one = create(:product, categories: [expected_category])
          product_two = create(:product, :with_category)
          get :index, params: { filter: { category_names: 'Expected' } }
          expect(json.dig(:data).size).to eq(1)
          expect(json.dig(:data, 0, :id)).to eq(product_one.id.to_s)
        end

        it 'filters by categories' do
          expected_category = create(:category, name: 'Expected Category' )
          create(:product, categories: [expected_category])
          create(:product, categories: [expected_category])
          get :index, params: { filter: { category_names: 'Expected' } }
          expect(json.dig(:data).size).to eq(2)
        end

        it 'filters by categories' do
          product_one = create(:product, :with_category)
          product_two = create(:product, :with_category)
          get :index, params: { filter: { category_names: 'NON_EXISTENT' } }
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

    context 'pagination' do
      it 'paginates by page size' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { page: { size: 2 } }
        expect(json.dig(:data).size).to eq(2)
        expect(json.dig(:data, 0, :id)).to eq(product_one.id.to_s)
        expect(json.dig(:data, 1, :id)).to eq(product_two.id.to_s)
      end

      it 'paginates by page number and size' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { page: { number: 2, size: 2 } }
        expect(json.dig(:data).size).to eq(1)
        expect(json.dig(:data, 0, :id)).to eq(product_three.id.to_s)
      end

      it 'passes page_number, page_size and total_page_count in meta field' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { page: { number: 2, size: 1 } }
        expect(json.dig(:data).size).to eq(1)
        expect(json.dig(:meta, :page_number).to_i).to eq(2)
        expect(json.dig(:meta, :page_size).to_i).to eq(1)
        expect(json.dig(:meta, :page_count).to_i).to eq(3)
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
