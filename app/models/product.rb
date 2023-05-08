class Product < ApplicationRecord
  has_many :category_products
  has_many :categories, through: :category_products
  # has_and_belongs_to_many :categories

  validate :title_is_shorter_than_description
  validates :title, :description, presence: true
  validates :price, numericality: { greater_than: 0 }
  before_save :strip_html_from_description

  before_save :title_to_lowercase

  def title_is_shorter_than_description
    return unless description.length < title.length

    errors.add(:description, 'cant be shorter than description')
  end
  scope :published, -> { where(published: true) }
  scope :priced_more_than, ->(price) { where('price > ? ', price) }

  # add the before _save hook
  def strip_html_from_description
    self.description = ActionView::Base.full_sanitizer.sanitize(description)
  end

  def title_to_lowercase
    self.title = title.downcase
  end

  def self.page_for_administration(page)
    published.order(created_at: :desc).paginate(page: page, per_page: 10)
  end
end
