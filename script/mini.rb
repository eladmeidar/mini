require File.dirname(__FILE__) + '/../lib/mini'

abort("script/mini.rb <server> <port> <user> <password> <main channel> <channel2>. don't use hashes for the chans. ") unless ARGV.length >= 4
server, port, user, password, *channels = ARGV

EventMachine::run do
  @irc = Mini::IRC.connect \
    :server => server, 
    :port => port, 
    :user => user,
    :password => password, 
    :channels => [channels].flatten

  Mini::Listener.connection = @irc
  EventMachine::start_server("0.0.0.0", 12345, Mini::Listener) 
end