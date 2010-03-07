require "thin"
require "thin/async"
require "json"

class Poll
  def initialize(app, messages)
    @messages = messages
    @app = app
  end
  
  def check(response)
    if @messages.size > last_messages_size
      response << @messages.to_json
      timer.cancel
      response.done
    end
  end
  
  def call(env)
    return @app.call(env) unless env["PATH_INFO"] =~ /^\/poll/
    
    response = Thin::AsyncResponse.new(env)
    last_messages_size = @messages.size
    
    timer = EM.add_periodic_timer(0.1) do
      if @messages.size > last_messages_size
        response << @messages.to_json
        timer.cancel
        response.done
      end
    end
    
    response.finish
  end
end
