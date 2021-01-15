require 'rubygems'
require 'pry'

Dir[File.dirname(__FILE__) + "/models/*.rb"].map { |file| require file }

require_relative "config/config"

binding.pry