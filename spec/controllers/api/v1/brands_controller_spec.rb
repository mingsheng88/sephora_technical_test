describe Api::V1::BrandsController, type: :controller do
  describe 'index' do
    it 'lists all brands (single)' do
      brand_one = create(:brand)
      get :index
      expect(json).to match_resources([brand_one])
    end

    it 'lists all brands (multiple)' do
      brand_one, brand_two = create_list(:brand, 2)
      get :index
      expect(json).to contain_resources([brand_one, brand_two])
    end
  end
end
