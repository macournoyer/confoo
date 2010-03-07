require "rubygems"
require "sinatra"
require "haml"
require "sass"
require "poll"

$messages = []

get "/" do
  haml :chat
end

post "/messages" do
  $messages << params[:message]
end

use Poll, $messages

get "/style.css" do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end
