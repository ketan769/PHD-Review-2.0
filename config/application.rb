
require_relative 'boot'

require 'rails/all'

environment.append_path File.join(
    Gem::Specification.find_by_name('popper_js').gem_dir, 'assets', 'javascripts')

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
