Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.ingest_folder = 'public/data/ingest/'
  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Show full error reports.
  # JL : 16/07/2019 : Turning off so I can see 404 page etc
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.cache_store = :mem_cache_store

  # 21/11/2018 JL:
  # config.active_job.queue_adapter     = :inline
  config.active_job.queue_adapter     = :sidekiq

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

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
  config.assets.debug = false

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
  IIIF_SERVER_URL='http://digcoll-imgsrv02.tcd.ie:8182/iiif/2/'
  #IIIF_SERVER_URL='http://127.0.0.1:8080/cantaloupe-4.1.2/iiif/2/'

end
