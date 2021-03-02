Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.persistent_hostpath = 'http://localhost:3000/concern/works/'

  config.ingest_folder = 'public/data/ingest/'

  config.doi_prefix = '10.81003'
  config.datacite_service = 'https://api.test.datacite.org/'
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  # JL : 16/07/2019 : Turning off so I can see 404 page etc
  # TODO
  config.consider_all_requests_local = false

  # 21/11/2018 JL:
  # config.active_job.queue_adapter     = :inline
  config.active_job.queue_adapter     = :sidekiq

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
   address: 'smtp.tcd.ie',
   port: '25',
   #user_name: 'MY_USER_NAME',
   #password: 'MY_PASSWORD',
   verify_ssl: false,
   authentication: 'plain',
   enable_starttls_auto: false
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false
  config.assets.raise_runtime_errors = false


  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # cloned from https://github.com/UCLALibrary/californica/pull/312/commits/7cdb819a8e08d69f5250aa4a1cd19d65d18f89ed
  # If there is a non-RIIIF IIIF server, uncomment; else, leave commented
  IIIF_SERVER_URL='http://127.0.0.1:8182/iiif/2/'
  #IIIF_SERVER_URL='http://127.0.0.1:8080/cantaloupe-4.1.2/iiif/2/'

  config.web_console.whitelisted_ips = ['172.0.0.0/8', '192.168.0.0/16', '127.0.0.1']
end
