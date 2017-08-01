class Post < ActiveRecord::Base
  before_create :create_slug
  
  validates :title, :content, :presence => true
  validates :title, length: { maximum: 250 }
  validates :content, length:  { maximum: 5000 }

  def year
    created_at.year
  end
  
  def month
    created_at.strftime("%m")
  end
  private
    def create_slug
      self.slug = title.parameterize 
    end
  
  
  
end