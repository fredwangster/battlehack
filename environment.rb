require 'rubygems'
require 'bundler/setup'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-migrations'
require 'ostruct'
require 'sinatra' unless defined?(Sinatra)

configure :development do
   SiteConfig = OpenStruct.new(
		   :title => 'Petitionly',
		   :author => 'Fred Wang',
		   :url_base => 'http://localhost:4567/'
		)

   #load models
   $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
   Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb"){ |lib| require File.basename(lib, '.*')}
 
   DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3:///#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db"))
   
   DataMapper.auto_upgrade!

end

configure :production do
   DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_BRONZE_URL'] || 'postgres://localhost/mydb')
   
end
