require 'iqvoc/environments/test'

if Iqvoc::Cedar.const_defined?(:Application)
  Iqvoc::Cedar::Application.configure do
    # Settings specified here will take precedence over those in config/environment.rb
    Iqvoc::Environments.setup_test(config)
  end
end
