=begin class User
  include DataMapper::Resource
  
  property :id,		Serial
  property :name,	String
  property :email,	String
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_presence_of :name
  validates_presence_of :email
  has n, :petitions
end
=end
