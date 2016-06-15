require 'sinatra'
require_relative 'twitter'

get '/tweets' do
	generate_tweets_web
end

get '/upload' do
	upload_tweets(true)
	"OK"
end