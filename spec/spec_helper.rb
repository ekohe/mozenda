$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require 'rspec'
require 'rspec/its'
require 'mozenda' 
require 'date'
require 'yaml'

yaml = YAML.load_file(File.join(File.dirname(__FILE__), 'mozenda.yml'))

Mozenda.configuration do |config|
  config.web_service_key  = yaml["web_service_key"]
  config.debug            = yaml["debug"]
end

Mozenda.s3_configuration do |config|
  config.access_key = yaml["aws_access_key_id"]
  config.secret_key = yaml["aws_secret_access_key"]
  config.bucket     = yaml["bucket_name"]
  config.region     = yaml["region"]
  config.file_dir   = yaml["file_dir"]
end

RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_has_behavior, 'has behavior:'
end