require 'active_support'
require 'active_support/all'

Dir.glob('./app/**/*.rb').each { |rb_file| require_relative rb_file }
