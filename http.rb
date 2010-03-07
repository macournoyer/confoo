require "rubygems"
require "eventmachine"
require "net/http/parser"

module Connection
  attr_accessor :app
  
  def post_init
    @parser = Net::HTTP::RequestParser.new
    @parser.on_headers_complete = proc { |env| @env = e }
  end
  
  def receive_data(data)
    @parser << data
  end
end

EM.run do
  trap("INT") { EM.stop }
  server = EM.start_server "0.0.0.0", 3000, Connection
  server.app = proc do |env|
    [
      200,
      {},
      ["ok"]
    ]
  end
end