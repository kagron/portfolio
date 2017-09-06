class Project < ActiveRecord::Base
  before_create :create_slug
  
  validates :avatar, :title, :description, :presence => true
  validates :title, length: { maximum: 250 }
  validates :description, length:  { maximum: 5000 }
  
  has_attached_file :avatar,
                    :styles => { :large => "1000x1000", :medium => "500x500>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  
  private
    def create_slug
      self.slug = title.parameterize 
    end
end
