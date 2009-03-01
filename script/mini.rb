require File.dirname(__FILE__) + '/../lib/mini'

abort("script/mini.rb <server> <port> <user> <password> <main channel> <channel2>. don't use hashes for the chans. ") unless ARGV.length >= 4
mini_secret, mini_port, web_port, server, port, user, password, *channels = [ENV['MINI_SECRET'], ENV['MINI_PORT'], ENV['WEB_PORT'], ARGV].flatten

EventMachine::run do
  Mini::IRC.connect \
    :server => server, 
    :port => port, 
    :user => user,
    :password => password, 
    :channels => [*channels]
  
  EventMachine::start_server("0.0.0.0",  mini_port || 12345, Mini::Listener)  
  @@web.run! :port => 2345 || web_port
end