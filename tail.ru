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


class App
  def call(env)
    response = Thin::AsyncResponse.new(env)
    
    response << "<html><body>"
    response << " " * 2048
    connection = EM.popen "tail -f tail.log", Connection
    connection.response = response
    
    response.finish
  end
end

run App.new