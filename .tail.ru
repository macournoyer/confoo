# usage:
# 
#   thin start -R tail.ru
#   echo blop >> tail.log
# 
require "thin"
require "thin/async"

module Connection
  attr_accessor :response
  
  def receive_data(data)
    response << "<pre>#{data}</pre>"
  end
  
  def unbind
    response.done
  end
end

class Runner
  def initialize(command)
    @command = command
    puts "Running #{@command} ..."
  end
  
  def call(env)
    response = Thin::AsyncResponse.new(env)
    
    response << "<html><body>"
    response << " " * 2048
    connection = EM.popen @command, Connection
    connection.response = response
    
    response.finish
  end
end

run Runner.new("tail -f tail.log")