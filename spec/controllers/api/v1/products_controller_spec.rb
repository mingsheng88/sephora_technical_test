describe Api::V1::ProductsController, type: :controller do
  describe 'GET api/v1/products' do
    it 'returns all products' do
      product, product_two = create_list(:product, 2, :with_category)
      get :index
      expect(json).to contain_resources([product, product_two])
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

      expect(json).to contain_resource_count_of(1)
      expect(json).to match_resources([expected_product_one])
      expect(json).to have_page_count(3)
    end

    context 'filtering' do
      context 'categories' do
        it 'filters by categories' do
          expected_category = create(:category, name: 'Expected Category' )
          product_one = create(:product, categories: [expected_category])
          product_two = create(:product, :with_category)
          get :index, params: { filter: { category_names: 'Expected' } }
          expect(json).to contain_resource_count_of(1)
          expect(json).to match_resources([product_one])
        end

        it 'filters by categories' do
          expected_category = create(:category, name: 'Expected Category' )
          create(:product, categories: [expected_category])
          create(:product, categories: [expected_category])
          get :index, params: { filter: { category_names: 'Expected' } }
          expect(json).to contain_resource_count_of(2)
        end

        it 'filters by categories' do
          product_one = create(:product, :with_category)
          product_two = create(:product, :with_category)
          get :index, params: { filter: { category_names: 'NON_EXISTENT' } }
          expect(json).to contain_resource_count_of(0)
        end
      end

      context 'price' do
        it 'filters by price_to' do
          product_one = create(:product, price: 12)
          product_two = create(:product, price: 15)
          get :index, params: { filter: { price_to: 13 } }
          expect(json).to contain_resource_count_of(1)
          expect(json).to contain_resources([product_one])
        end

        it 'filters by price_from' do
          product_one = create(:product, price: 12)
          product_two = create(:product, price: 15)
          get :index, params: { filter: { price_from: 13 } }
          expect(json).to contain_resource_count_of(1)
          expect(json).to contain_resources([product_two])
        end

        it 'filters by price_from and price_to' do
          product_one = create(:product, price: 12)
          product_two = create(:product, price: 15)
          product_three = create(:product, price: 18)
          get :index, params: { filter: { price_from: 13, price_to: 16 } }
          expect(json).to contain_resource_count_of(1)
          expect(json).to contain_resources([product_two])
        end
      end
    end

    context 'sorting' do
      it 'sorts by price desc' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { sort: '-price' }
        expect(json).to match_resources([product_three, product_one, product_two])
      end

      it 'sorts by price asc' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { sort: 'price' }
        expect(json).to match_resources([product_two, product_one, product_three])
      end
    end

    context 'pagination' do
      it 'paginates by page size' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { page: { size: 2 } }
        expect(json).to contain_resource_count_of(2)
        expect(json).to match_resources([product_one, product_two])
      end

      it 'paginates by page number and size' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { page: { number: 2, size: 2 } }
        expect(json).to contain_resource_count_of(1)
        expect(json).to match_resources([product_three])
      end

      it 'passes page_number, page_size and total_page_count in meta field' do
        product_one = create(:product, price: 15)
        product_two = create(:product, price: 12)
        product_three = create(:product, price: 18)
        get :index, params: { page: { number: 2, size: 1 } }
        expect(json).to contain_resource_count_of(1)
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
      expect(json).to match_resource(product)
    end
  end
end
