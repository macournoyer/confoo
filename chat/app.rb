require "rubygems"
require "sinatra"
require "haml"
require "sass"

get "/" do
  haml :chat
end

get "/style.css" do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end
