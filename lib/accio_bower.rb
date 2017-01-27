require 'rails'
require 'accio_bower/railtie'
require 'accio_bower/assets_processor'

module AccioBower
  DEFAULT_EXTENSIONS = %w[png gif jpg jpeg ttf svg eot woff woff2]

  def self.warn_all(msgs)
    logger = Logger.new(STDOUT)
    msgs = Array(msgs)
    msgs.each {|msg| logger.warn(msg) }
    msgs.each {|msg| ::Rails.logger.warn(msg) }
  end
end
