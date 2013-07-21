require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end


get '/' do 
   erb :home
end

#create petition
post '/petition' do
   p = Petition.new
   p.attributes = {
	:title => params[:title],
 	:description => params[:description],
	:email => params[:email],
	:password => params[:password],
	:goal => params[:goal],
	:created_at => Time.now,
	:updated_at => Time.now	   
   }
   if p.save
	r_url = "/petition/#{p.id}"
	redirect r_url
   else
	text = "Could not save {#p.attributes}"
	"Could not save #{p.attributes}"
   end
end

#form to sign petition with info
get '/petition/:id' do
   @petition = Petition.get(params[:id])
   s = Signature.new
   s.attributes = {
	:name => params[:name],
	:email => params[:email]
   }
   @s = s
   @completed = Petition.get(params[:id]).signatures.count
   if @petition
	erb :petition
   else
	"Could not find petition"
   end
end


#signature page
post '/petition/:id/sign1' do
   @petition = Petition.get(params[:id])
   erb :signature
end

post '/petition/:id/sign2' do
   pass = Petition.get(params[:id])
   @petition = Petition.get(params[:id])
   s = Signature.new
   s.attributes = {
	:name => params[:name],
	:email => params[:email],
	:siggy => params[:siggy]
   }
   @s = s
   pass.signatures << Signature.create(
	:name => params[:name],
	:email => params[:email],
	:siggy => params[:siggy]
  )
   
  if pass.save
	erb :thankyou
  end
end

#login for admin
get '/user/petition/:id' do
   @petition = Petition.get(params[:id])
   erb :login
end


#download petition
post '/user/petition/:id' do
   @petition = Petition.get(params[:id])
   changethis = Petition.count(:id => params[:id], :password => params[:password])   
   if changethis == 0
   else
	erb :admin
   end
end


not_found do
  halt 404, 'page not found'
end

