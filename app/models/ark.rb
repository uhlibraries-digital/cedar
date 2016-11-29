class ArkProxy < Flexirest::ProxyBase
  get "/id/:id" do
    response = passthrough
    translate(response) do |body|
      body = body["ark"]
      body
    end
  end
end

class Ark < Flexirest::Base
  proxy ArkProxy
  base_url Iqvoc.config['minter.api_endpoint']
  
  before_request :add_authentication_details
  
  perform_caching false

  get :find, "/id/:id"
  put :save, "/id/:id"
  post :create, "/arks/mint/" + Iqvoc.config['minter.prefix']

  def add_authentication_details(name, request)
    request.headers["api-key"] = Iqvoc.config['minter.api_key']
  end

end