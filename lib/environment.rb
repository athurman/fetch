#!/usr/bin/env ruby
require_relative 'database'
require_relative '../models/shelterdog'


class Environment
  def self.environment= environment
    @@environment = environment
  end

  def self.database_connection
    Database.connection(@@environment)
  end
end