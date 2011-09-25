class Page < ActiveRecord::Base

  validates_presence_of :name, :body, :keywords, :page_title, :page_body
  validates_uniqueness_of :permalink, :page_title

  before_save :set_permalink

  scope :sitemap, where('permalink not in(?)', %W(home contato))

  def set_permalink
    self.permalink = name.parameterize
  end

end
