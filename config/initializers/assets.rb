# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Add GOVUK image asset path
Rails.application.config.assets.paths << Rails.root.join('node_modules/govuk-frontend/assets/images')
# Add GOVUK font asset path, remove if not using NTA font
Rails.application.config.assets.paths << Rails.root.join('node_modules/govuk-frontend/assets/fonts')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# Precompile the GOVUK image assets:
Rails.application.config.assets.precompile += %w( govuk-frontend/assets/images/* )

# Precompile the GOVUK font assets, remove if not using:
Rails.application.config.assets.precompile += %w( govuk-frontend/assets/fonts/* )