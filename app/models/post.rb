

class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :link, type: String
  field :description, type: String
  field :category, type: String
  belongs_to :user

  mount_uploader :image, PhotoUploader

  def date_published
  	# technically we don't need self. because its an instance variable so it's implied
  	self.created_at.localtime.strftime("%A, %B %-d, %Y at %l:%M %p")
  end

  def date_added
    created_at.localtime.strftime("%-m/%-d/%Y | %l:%M %p")
  end

  def self.random(current_post)
    shuffled_posts = self.all.shuffle
    random_post = shuffled_posts.first
    if random_post != current_post
      random_post
    else 
      shuffled_posts[1]
    end
  end

  


end
