class Category < ApplicationRecord
  has_ancestry

  has_and_belongs_to_many :products

  before_save :generate_slug_before_save

  validate :slug_not_changed

  def slug_not_changed
    if slug_changed?
      errors.add(:slug, 'Slug can only be auto-generated!')
    end
  end

  def generate_slug_before_save
    self.slug = name.parameterize
  end
end
