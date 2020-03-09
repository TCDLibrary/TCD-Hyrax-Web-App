Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.ingest_folder = 'public/data/ingest/'
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  # JL: 2020-02-05
  #config.cache_classes = false

  # JL: 2020-02-05 Do not eager load code on boot.
  #config.eager_load = false

  # JL: pre-production config 2020/05/02
  # Code is not reloaded between requests.
  config.cache_classes = true
  config.eager_load = true
  config.assets.js_compressor = Uglifier.new(harmony: true)

  # JL: turn on asset fingerprinting. Relates to secrets and token verification
  config.assets.digest = true

  # Show full error reports.
  # JL : 16/07/2019 : Turning off so I can see 404 page etc
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
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Path to the file characterization tool
  config.fits_path = "/opt/app/Fits/fits.sh"

  # cloned from https://github.com/UCLALibrary/californica/pull/312/commits/7cdb819a8e08d69f5250aa4a1cd19d65d18f89ed
  # If there is a non-RIIIF IIIF server, uncomment; else, leave commented
  #IIIF_SERVER_URL='http://127.0.0.1:8182/iiif/2/'
  # JL: 07/02/2020 : IIIF_SERVER_URL='http://digcoll-imgsrv02.tcd.ie:8182/iiif/2/'
    # JL : 2020-02-10 : IIIF_SERVER_URL='http://digcoll-web02.tcd.ie/iiif/2/'
  IIIF_SERVER_URL='/iiif/2/'
  #IIIF_SERVER_URL='http://127.0.0.1:8080/cantaloupe-4.1.2/iiif/2/'

  # JL : TODO. Check if I need this. Added it because viewer giving errors on VM-099
  config.public_file_server.enabled = true

end
