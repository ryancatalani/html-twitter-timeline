require 'json'
require 'sinatra'
require 'sinatra/json'
require_relative 'twitter'

# set :json_encoder, :to_json

get '/tweets' do
	generate_tweets()
end

get '/upload' do
	upload_tweets()
	"OK"
end