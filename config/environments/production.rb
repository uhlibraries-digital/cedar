require 'iqvoc/environments/production'

if Iqvoc::Cedar.const_defined?(:Application)
  Iqvoc::Cedar::Application.configure do
    # Settings specified here will take precedence over those in config/environment.rb
    Iqvoc::Environments.setup_production(config)

    config.action_controller.perform_caching = true
    config.cache_store = :memory_store, { size: 64.megabytes }

    config.serve_static_files = true
    if ENV["RAILS_LOG_TO_STDOUT"].present?
      logger           = ActiveSupport::Logger.new(STDOUT)
      logger.formatter = config.log_formatter
      config.logger    = ActiveSupport::TaggedLogging.new(logger)
    end
    config.log_level = :warn
  end
end
