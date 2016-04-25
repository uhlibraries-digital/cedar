class ArkProxy < ActiveRestClient::ProxyBase
  get "/id/:id" do
    response = passthrough
    translate(response) do |body|
      body = body["ark"]
      body
    end
  end
end

class Ark < ActiveRestClient::Base
  proxy ArkProxy
  base_url Iqvoc.config['minter.api_endpoint']
  before_request :add_authentication_details
  perform_caching false

  get :find, "/id/:id"
  put :save, "/id/:id"
  post :create, "/arks/mint"

  def add_authentication_details(name, request)
    request.headers["api-key"] = Iqvoc.config['minter.api_key']
  end

end