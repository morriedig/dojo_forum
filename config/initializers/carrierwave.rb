CarrierWave.configure do |config|
  config.fog_provider = "fog/aws"
  config.fog_credentials = {
    provider:              "AWS",
    region:                "ap-northeast-1",
    aws_access_key_id:     ENV["key_id"],
    aws_secret_access_key: ENV["access_key"],
  }
  config.fog_directory = ENV["fog_directory"]
end