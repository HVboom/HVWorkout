# frozen_string_literal: true

# Search path setup for I18n data files
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

# Permitted locales available for the application
I18n.available_locales = [:en, :de]
I18n.enforce_available_locales = true

# Set default locale
I18n.default_locale = :de
