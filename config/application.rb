require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Grupjalan
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Jakarta'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # disable generators
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.view_specs false
    end

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.paths << "#{Rails.root}/app/assets/fonts" 
    and update:

    @font-face {
      font-family: 'FontAwesome';
      src: url('/assets/fontawesome-webfont.eot?v=4.0.3');
      src: url('/assets/fontawesome-webfont.eot?#iefix&v=4.0.3') format('embedded-opentype'), 
      url('/assets/fontawesome-webfont.woff?v=4.0.3') format('woff'),
      url('/assets/fontawesome-webfont.ttf?v=4.0.3') format('truetype'), 
      url('/assets/fontawesome-webfont.svg?v=4.0.3#fontawesomeregular') format('svg');
      font-weight: normal;
      font-style: normal;
    }

  end
end
