require_relative "development"

Rails.application.configure do
  # Allow accessing the web console from the Docker host
  config.web_console.permissions = '0.0.0.0/0'
  
  # Use redis for caching in development
  config.cache_store = :redis_cache_store, { url: ENV.fetch("REDIS_URL", "redis://redis:6379/1") }
end
