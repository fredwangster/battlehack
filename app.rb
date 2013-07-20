require 'rubygems'
require 'sinatra'

get '/' do 
   erb :home
end

get '/petition' do
   erb :petition
end

get '/signature' do 
  erb :signature
end

get '/thankyou' do
  erb :thankyou
end

get '/admin' do
  erb :admin
end

get '/login' do
  erb :login
end

get '/about' do 
   "About me"
end

not_found do
  halt 404, 'page not found'
end

