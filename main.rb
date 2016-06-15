require 'sinatra'
require_relative 'twitter'

get '/tweets' do
	generate_tweets_web
end

get '/update' do
	upload_tweets(true)
	"OK"
end