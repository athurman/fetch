#!/usr/bin/env ruby

require 'optparse'

class ParseArguments
  def self.parse
    options = { environment: "production" }
    OptionParser.new do |opts|
      opts.banner = "Usage: fetchdog [command] [options]"
      opts.on("-b", "--breed [DOGBREED]", "The dog breed") do |breed|
        options[:breed] = breed
      end
      opts.on("-s", "--shelter [SHELTER]", "The shelter name") do |shelter|
        options[:shelter] = shelter
      end
      opts.on("-a", "--age [DOGAGE]", "The dog age") do |age|
        options[:age] = age
      end
      opts.on("-w", "--weight [DOGWEIGHT]", "The dog weight") do |weight|
        options[:weight] = weight
      end
      opts.on("--status [DOGSTATUS]", "The dog status") do |status|
        options[:status] = status
      end
      opts.on("--environment [ENV]", "The database environment") do |env|
        options[:environment] = env
      end
    end.parse!
    options[:name] = ARGV[1]
    options[:command] = ARGV[0]
    options
  end

  def self.validate options
    errors = []
    if options[:name].nil? or options[:name].empty?
      errors << "You must provide the name of the dog you are adding.\n"
    end

    missing_things = []
    missing_things << "breed" unless options[:breed]
    missing_things << "shelter" unless options[:shelter]
    missing_things << "age" unless options[:age]
    missing_things << "weight" unless options[:weight]
    missing_things << "status" unless options[:status]

    unless missing_things.empty?
      errors << "You must provide the #{missing_things.join(" and ")} of the dog you are adding.\n"
    end
    errors
  end

end