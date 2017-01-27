class AccioBower::AssetsProcessor
  def initialize(app)
    @app = app
    self.components = [@app.root.join('vendor', 'assets', 'bower_components')]
    self.extensions = ::AccioBower::DEFAULT_EXTENSIONS
  end

  attr_reader :components
  def components=(v)
    @components = Array(v).map(&:to_s)
  end

  attr_reader :extensions
  def extensions=(v)
    @extensions = Array(v).map(&:to_s)
    @url_exp = Regexp.new(%{(url\\(('|"|))((.+?)\\.(%s))(.*?\\2\\))} % [v.join('|')])
  end

  attr_accessor :output_prefix

  def call(input)
    output = input[:data]

    unless assets_debug?
      if is_component?(input[:filename])
        output = fix_assets_path(input)
      end
    end

    {data: output}
  end

  def fix_assets_path(input)
    source_dir = File.dirname(input[:filename])

    input[:data].gsub @url_exp do |*args|
      # $1 = opening declaration      Ex: url('
      # $2 = quotation style          Ex: '
      # $3 = path with extension
      # $4 = path without extension
      # $5 = extension
      # $6 = closing declaration      Ex: ')

      # Copy opening and closing declarations.
      d1, d2 = $1.dup, $6.dup

      # Map relative url to physical path.
      path = File.expand_path("#{source_dir}/#{$3}")

      # Replace bower_components path to create relative uri.
      components.each do |base_path|
        path = path.gsub("#{base_path}/", '')
      end

      # Convert path to digest (if needed).
      if assets_digest?
        if @app.assets
          asset = @app.assets[path]
          if asset.nil?
            ::AccioBower.warn_all "AccioBower could not locate asset digest for \"#{path}\""
          else
            path = asset.digest_path
          end
        else
          ::AccioBower.warn_all [
                                    'AccioBower needs access to assets digests for precompilation.',
                                    "Try adding the following snippet to config/environments/#{::Rails.env}.rb",
                                    "  config.assets.compile = File.basename($0).eql?('rake')"
                                ]
          raise 'AccioBower fatal error.'
        end
      end

      # Wrap resultant path in declaration.
      "#{d1}#{output_prefix}#{path}#{d2}"
    end
  end

  def assets_debug?
    @app.config.assets.debug
  end

  def assets_digest?
    @app.config.assets.digest
  end

  def is_component?(input_path)
    components.any? { |base_path| input_path.to_s.starts_with?(base_path) }
  end
end
