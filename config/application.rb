require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mirror
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(services)
    config.autoload_paths += %W(serializers)
    config.autoload_paths += %W(validators)
    Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }

    config.i18n.default_locale = 'zh-TW'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.active_job.queue_adapter = :sidekiq

    config.time_zone = "Taipei"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
