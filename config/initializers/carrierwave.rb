unless Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:      Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key:  Rails.application.secrets.aws_secret_access_key,
      region:                 Rails.application.secrets.aws_region,
      # host:                  Rails.application.secrets.aws_host,             # optional, defaults to nil
      # endpoint:              '' # optional, defaults to nil
    }  
    config.asset_host = Rails.application.secrets.aws_cdn_host if Rails.env.staging? || Rails.env.production?
    config.fog_directory  = "pathub-bucket-#{Rails.env}"
    # config.fog_public     = false                                        # optional, defaults to true
    # config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
  end
end
