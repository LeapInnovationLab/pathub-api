Apipie.configure do |config|
  config.app_name                = "PathHub"
  config.copyright               = "&copy; #{Date.today.year} taketheleap.co"
  config.api_base_url            = "/"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.default_version         = "1"
  config.app_info["1"] = "PathHub - description pending."
  config.validate_presence       = false
end
