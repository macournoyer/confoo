require "rubygems"
require "eventmachine"

module Connection
  def post_init
    puts "Connected"
  end

  def receive_data(data)
    send_data data
  end
  
  def unbind
    puts "Closed"
  end
end


EM.run do
  EventMachine.start_server "0.0.0.0", 3000, Connection
end