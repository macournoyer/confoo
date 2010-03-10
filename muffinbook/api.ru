$:.unshift File.dirname(__FILE__) + "/vendor/em-mysql/lib"
require "em/mysql"
require "thin"
require "thin/async"
require "yajl"

EventedMysql.settings.update :database => "muffins_development",
                             :user => "root",
                             :encoding => "utf8",
                             :connections => 4


class Api
  def initialize
    @encoder = Yajl::Encoder.new(:terminator => nil)
  end
  
  def call(env)
    response = Thin::AsyncResponse.new(env)
    
    EventedMysql.select("SELECT title, description FROM recipes ORDER BY RAND()") do |results|
      recipe = {
        :title => results.first["title"],
        :description => results.first["description"]
      }
      
      @encoder.encode(recipe) do |chunk|
        if chunk.nil? # got our terminator, encoding is done
          response.done
        else
          response.write chunk
        end
      end
    end
    
    response.finish
  end
end

run Api.new