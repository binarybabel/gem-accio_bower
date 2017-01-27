module AccioBower
  class Railtie < Rails::Railtie
    railtie_name :accio_bower

    config.accio_bower = ActiveSupport::OrderedOptions.new

    config.before_initialize do |app|
      @processor = ::AccioBower::AssetsProcessor.new(app)
      Sprockets.register_preprocessor 'text/css', @processor
      Sprockets.register_preprocessor 'application/javascript', @processor
      app.config.accio_bower.components = nil
      app.config.accio_bower.extensions = nil
      config.assets.compile ||= File.basename($0).eql?('rake')
    end

    config.after_initialize do |app|
      %w{components extensions}.each do |cfg|
        if (val = app.config.accio_bower.send(cfg))
          @processor.send("#{cfg}=".to_sym, val)
        end
      end

      @processor.output_prefix = ENV['ACCIOBOWER_PREFIX'] || ENV['BOWER_PREFIX']

      app.config.assets.paths += @processor.components
      @processor.extensions.each do |ext|
        @processor.components.each do |base_path|
          app.config.assets.precompile += Dir.glob("#{base_path}/**/*.#{ext}")
        end
      end

      unless @processor.components.any? { |path| Dir.exist?(path) }
        puts ''
        puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
        puts 'AccioBower: Could not locate a bower_components directory.'
        puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
        puts ''
        puts 'https://git.io/accio_bower#Installation'
        puts ''
        Rails.logger.error('AccioBower could not locate a bower_components directory.')
        Rails.logger.info('https://git.io/accio_bower#Installation')
      end
    end
  end
end
