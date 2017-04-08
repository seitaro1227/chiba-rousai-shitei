# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Mime::Type.register "application/json", :geojson
