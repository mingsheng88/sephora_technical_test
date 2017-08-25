# Set up logging to be the same in all environments but control the level
# through an environment variable.
Rails.application.config.log_level = ENV['LOG_LEVEL']

# Log to STDOUT because Docker expects all processes to log here. You could
# then redirect logs to a third party service on your own such as systemd,
# or a third party host such as Loggly, etc..
logger           = ActiveSupport::Logger.new(STDOUT)
logger.formatter = Rails.application.config.log_formatter
Rails.application.config.log_tags  = %i[subdomain uuid]
Rails.application.config.logger    = ActiveSupport::TaggedLogging.new(logger)
