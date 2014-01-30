#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/clean'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

task :bootstrap_database do
  database = Environment.database_connection("production")
  create_tables(database)
end

task :test_prepare do
  File.delete("db/fetch_test.sqlite3")
  database = Environment.database_connection("test")
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE shelterdogs (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), breed_id integer, shelter varchar(50), age varchar(5), weight varchar(1), status varchar(5))")
end
