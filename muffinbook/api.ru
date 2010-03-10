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
  def call(env)
    
  end
end

run Api.new