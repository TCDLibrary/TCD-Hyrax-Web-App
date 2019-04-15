require 'mini_magick'

MiniMagick.configure do |config|
  config.shell_api = "posix-spawn"
  MiniMagick.logger = Rails.logger
  MiniMagick.logger.level = Logger::DEBUG
end
