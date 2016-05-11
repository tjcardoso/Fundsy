require 'faraday'
require 'json'


BASE_URL = "http://localhost:3000"
API_KEY = "ac9963c6aa5f99bb42b05c26b4f55a49d0a7476b2bc1119daeb2b28dc3d11c9f"

conn = Faraday.new(:url => BASE_URL) do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

response = conn.get "/api/v1/campaigns", {api_key: API_KEY}     # GET http://sushi.com/nigiri/sake.json

campaigns = JSON.parse(response.body)

campaigns.each do |campaign|
  puts campaign["title"]
end
