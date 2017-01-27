# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'accio_bower/version'

Gem::Specification.new do |spec|
  spec.name          = 'accio_bower'
  spec.version       = AccioBower::VERSION
  spec.authors       = ['BinaryBabel OSS']
  spec.email         = ['oss@binarybabel.org']

  spec.summary       = 'Bower asset processor for Rails, supporting CSS/JS URL rewriting (images, fonts, etc.), and production hashes/digests.'
  spec.description   = 'Import externally managed Bower assets via Rails Sprockets while preserving links to relative dependencies, and maintaining hash digests in production.'
  spec.homepage      = 'https://github.com/binarybabel/gem-accio_bower'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  if File.exist?('INSTALL.txt')
    spec.post_install_message = File.read('INSTALL.txt')
  end

  spec.files += ['version.lock']
  spec.add_runtime_dependency 'versioneer', '~> 0.2'

  spec.add_runtime_dependency 'rails'
  spec.add_runtime_dependency 'sprockets'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
