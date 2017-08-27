describe Api::V1::ProductsController, type: :controller do
  context 'GET api/v1/products' do
    it 'returns all products' do
      product, product_two = create_list(:product, 2)
      get :index
      expect(json.dig(0, :id)).to eq(product.id)
      expect(json.dig(1, :id)).to eq(product_two.id)
    end
  end

  context 'GET api/v1/product/:product_id' do
    it 'returns a specified product' do
      product, product_two = create_list(:product, 2)
      get :show, params: { id: product }
      expect(json[:id]).to eq(product.id)
    end
  end
end
