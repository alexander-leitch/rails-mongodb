class Post
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Slug
  
  field :title, type: String, localize: true
  slug :title, history: true, localize: true
  field :body, type: String, localize: true
  
  #has_mongoid_attached_file :photo
  #validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  def send_to_twitter!
    Twitter.update("#{self.title} #{self.url}")
  end
end
