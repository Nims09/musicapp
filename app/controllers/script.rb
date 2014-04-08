require 'rubygems'
require 'oath'

# Keys
consumer_key = OAuth::Consumer.new(
	"LfSjQC9lnIDvl8jdNq5Sg",
	"bJBWLJbQzqv1wzAR9DqoKmHPuSK8CweviUUMCMsSWjk"
	)
access_token = OAuth::Token.new(
	"262060561-jwTGye3OunvnfIQ1m3rlB8g8MGGLrD0zZcxatOXx",
	"wLCMKcEnpDFdSnri9mLvze1pugvT26bubXfbSQlMMNmxx"
	)

# Base URL Value to hit twitter API
baseurl = "https://api.twitter.com"

# Address ti verify credentials
address = URI("#{baseurl}/1.1/account/verify_credentials.json")

# Set up SSL
http = Net::HTTP.new address.host, address.port
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# Build request and authorize
request = Net::HTTP::Get.new address.request_uri
request.oauth! http, consumer_key, access_token

#Issue the request and return the response
http.start
response = http.request request
puts "The response status was #{response.code}"