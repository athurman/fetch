#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'active_record'

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/../models/*.rb").each{|f| require f}

require_relative 'database'
require 'yaml'

class Environment
  def self.environment= environment
    @@environment = environment
  end

  def self.connect_to_database
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details[@@environment])
  end
end