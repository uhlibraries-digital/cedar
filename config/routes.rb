Rails.application.routes.draw do
  get 'vocabulary' => 'vocabulary#index', :defaults => { :format => 'ttl' } 
end
