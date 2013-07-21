class Petition
  include DataMapper::Resource
  
  property :id,			Serial
  property :title,		String
  property :description,	Text
  property :email,		Text
  property :password,           Text
  property :goal,		Integer
  property :created_at, 	DateTime
  property :updated_at, 	DateTime

  #belongs_to :user
  has n, :signatures
  validates_presence_of :title, :description, :email, :password, :goal
  
end

class Signature
#need refactoring... user should have signature
  include DataMapper::Resource

  property :id,			Serial
  property :name,		String
  property :email,		String
  property :siggy,		Text
  property :created_at,		DateTime

  belongs_to :petition
  validates_presence_of :name, :email, :siggy
end
