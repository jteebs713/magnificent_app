class User
  include Mongoid::Document

  attr_accessor :password
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
  	self.password_salt = BCrypt::Engine.generate_salt
  	self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(email, password)
  	user = User.where(email: email).first
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  		user
  	else
  		nil
  	end
  end



  field :username, type: String
  field :email, type: String	
  field :password_hash, type: String
  field :password_salt, type: String
  field :password_digest, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :category, type: String
  field :bio, type: String
  field :contact_info, type: String

 

  has_many :posts

end


