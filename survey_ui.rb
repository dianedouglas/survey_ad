require 'active_record'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configurations = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configurations)
