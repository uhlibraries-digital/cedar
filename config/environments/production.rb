require 'iqvoc/environments/production'

if Iqvoc::Cedar.const_defined?(:Application)
  Iqvoc::Cedar::Application.configure do
    # Settings specified here will take precedence over those in config/environment.rb
    Iqvoc::Environments.setup_production(config)
    config.serve_static_assets = true
    config.log_level = :warn
  end
end
