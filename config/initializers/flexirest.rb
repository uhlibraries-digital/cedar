Flexirest::Base.faraday_config do |faraday|
  faraday.ssl.verify = false
  faraday.adapter(:net_http)
end