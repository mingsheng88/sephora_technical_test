describe Category, type: :model do
  describe 'slug' do
    it 'generates slug on creation' do
      category = described_class.create(name: 'A Category Name')
      expect(category.slug).to eq('a-category-name')
    end

    it 'generates slug on update' do
      category = described_class.create(name: 'A Category Name')
      category.update(name: 'New Category Name')
      expect(category.slug).to eq('new-category-name')
    end

    it 'fails validation if modified' do
      category = described_class.create(name: 'something', slug: 'something else')
      expect(category).to be_invalid
    end

    it 'fails validation if modified' do
      category = described_class.create(name: 'A Category Name')
      category.update(name: 'Something', slug: 'something else')
      expect(category).to be_invalid
    end
  end
end
