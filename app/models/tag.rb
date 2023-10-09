class Tag < ApplicationRecord
  has_many :book_tag_relations, dependent: :destroy
  has_many :books, through: :book_tag_relations, dependent: :destroy

  before_validation :downcase_name
  validates :name, uniqueness: { case_sensitive: false}

  scope :merge_books, -> (tags){ }

  def self.search_books_for(content, method)
    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    elsif method == 'partial'
      tags = Tag.where('name LIKE ?', '%'+ content + '%')
    end
    return tags.inject(init = []) {|result, tag| result + tag.books }
  end
  private

  def downcase_name
    self.name = name.downcase if name.present?
  end
end
