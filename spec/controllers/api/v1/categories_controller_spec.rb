describe Api::V1::CategoriesController, type: :controller do
  describe 'index' do
    it 'lists all categories' do
      category = create(:category)
      get :index
      expect(json).to match_resources([category])
    end

    it 'lists all categories' do
      categories = create_list(:category, 2)
      get :index
      expect(json).to contain_resources(categories)
    end

    it 'lists only root categories' do
      root_category = create(:category)
      child_category = create(:category, parent: root_category)
      get :index
      expect(json).to match_resources([root_category])
    end
  end
end
