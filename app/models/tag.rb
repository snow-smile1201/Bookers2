class Tag < ApplicationRecord
  has_many :book_tag_relations, dependent: :destroy
  has_many :books, through: :book_tag_relations, dependent: :destroy
  
  before_validation :downcase_name
  validates :name, uniqueness: { case_sensitive: false}
  
  private
  
  def downcase_name
    self.name = name.downcase if name.present?
  end
end
