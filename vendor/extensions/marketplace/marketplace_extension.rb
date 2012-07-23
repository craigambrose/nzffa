# Uncomment this if you reference any of your controllers in activate
# require_dependency "application_controller"
require "radiant-marketplace-extension"
#require 'reader_validator'

class MarketplaceExtension < Radiant::Extension
  version     RadiantMarketplaceExtension::VERSION
  description RadiantMarketplaceExtension::DESCRIPTION
  url         RadiantMarketplaceExtension::URL

  # See your config/routes.rb file in this extension to define custom routes

  extension_config do |config|
    # config is the Radiant.configuration object
  end

  def activate
    # this seem to work as a method to overwrite the readers views
    ActionController::Base.prepend_view_path "#{RAILS_ROOT}/vendor/extentions/marketplace/app/views/"

    Page.class_eval { include Marketplace }
    tab 'Content' do
      add_item "Marketplace", "/admin/adverts", :after => "Pages"
    end
  end
end
