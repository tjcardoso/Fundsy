require "faraday"
require "json"

BASE_URL = "http://localhost:3000"
API_KEY  = "454e066f58699b304e30a2b223997ed47112787342e1cec9af260a543c4e6f70"

conn = Faraday.new(url: BASE_URL) do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

response = conn.get "/api/v1/campaigns", {api_key: API_KEY}

campaigns = JSON.parse(response.body)

campaigns.each do |campaign|
  puts campaign["title"]
end
