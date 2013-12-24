# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  permalink  :string(255)
#  keywords   :string(255)
#  page_title :string(255)
#  page_body  :text
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base

  validates_presence_of   :name, :page_title, :keywords
  validates_uniqueness_of :name

  has_and_belongs_to_many :posts, -> { active }

  default_scope -> { order('name ASC') }

  before_save :set_permalink

  def set_permalink
    self.permalink = name.parameterize
  end

end
