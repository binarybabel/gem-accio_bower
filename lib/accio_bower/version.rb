require 'versioneer'

module AccioBower
  VERSION = ::Versioneer::Config.new(::File.expand_path('../../../', __FILE__))
end
