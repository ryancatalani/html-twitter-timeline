require 'twitter'
require 'date'
require 'erb'
require 'fog'

def generate_tweets_web
	user = ENV['USERNAME']
	@tweets = get_tweets(user)
	@user = get_user_info(user)
	erb :tweets
end

def generate_tweets_rb
	user = ENV['USERNAME']
	@tweets = get_tweets(user)
	@user = get_user_info(user)

	erb = ERB.new(File.new('views/tweets.erb').read)
	return erb.result
end

def upload_tweets(web=false)
	connection = Fog::Storage.new({
	  provider: 'AWS',
	  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
	  aws_secret_access_key: ENV['AWS_SECRET_ACCESS']
	})

	directory = connection.directories.get("twitterembed")

	if web
		body = generate_tweets_web
	else
		body = generate_tweets_rb
	end

	file = directory.files.create({
		key: "#{ENV['USERNAME']}/tweets.html",
		body: body,
		public: true
	})
end

private

	def get_user_info(username)
		user = client.user(username)

		ret = {}
		ret[:name] = user.name
		ret[:image] = user.profile_image_uri
		ret[:screen_name] = user.screen_name

		return ret
	end

	def get_tweets(username)

		tweets = []

		client.search("from:#{username}", result_type: "recent", count: 5).each do |tweet|

			tweet_text = tweet.text.dup
			entities = []

			if tweet.uris?
				# p tweet.uris
				tweet.uris.each do |entity|
					indices = entity.indices
					replace = "<a href='#{entity.expanded_url}' target='_blank'>#{entity.display_url}</a>"
					entities << [indices, replace].flatten
				end
			end

			if tweet.media?
				# p tweet.media
				tweet.media.each do |entity|
					indices = entity.indices
					replace = "<a href='#{entity.expanded_url}' target='_blank'><img src='#{entity.media_url}' /></a>"
					entities << [indices, replace].flatten
				end
			end

			if tweet.hashtags?
				# p tweet.hashtags
				tweet.hashtags.each do |entity|
					indices = entity.indices
					replace = "<a href='https://twitter.com/hashtag/#{entity.text}' target='_blank'>##{entity.text}</a>"
					entities << [indices, replace].flatten
				end
			end

			if tweet.symbols?
				# p tweet.symbols
				tweet.symbols.each do |entity|
					indices = entity.indices
					replace = "<a href='https://twitter.com/hashtag/#{entity.text}' target='_blank'>$#{entity.text}</a>"
					entities << [indices, replace].flatten
				end
			end

			if tweet.user_mentions?
				# p tweet.user_mentions
				tweet.user_mentions.each do |entity|
					indices = entity.indices
					replace = "<a href='https://twitter.com/#{entity.screen_name}' target='_blank'>@#{entity.screen_name}</a>"
					entities << [indices, replace].flatten
				end
			end

			entities = entities.sort_by {|e| e[0]}.reverse

			entities.each do |entity_info|
				tweet_text.slice!(entity_info[0]..entity_info[1])
				tweet_text.insert(entity_info[0], " #{entity_info[2]}")
			end

			final = {}
			final[:html] = tweet_text
			final[:date] = tweet.created_at.strftime("%A, %b %e, %Y | %l:%M %P")
			final[:uri] = tweet.uri

			tweets << final

		end

		return tweets

	end

	def client
		client ||= Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV['CONSUMER_KEY']
		  config.consumer_secret     = ENV['CONSUMER_SECRET']
		  config.access_token        = ENV['ACCESS_TOKEN']
		  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
		end
		return client
	end