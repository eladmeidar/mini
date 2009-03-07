module Mini
  class Bot
    cattr_accessor :commands
    @@commands = {}
    
    def self.start(options)
      EventMachine::run do
        Mini::IRC.connect(options)
        EventMachine::start_server("0.0.0.0", options[:mini_port], Mini::Listener)
        @@secret = options[:secret]  
        @@web.run! :port => options[:web_port]
      end
    end
    
    def self.run(command, args)
      proc = Bot.commands[command]
      proc ? proc.call(args) : (puts "command #{ command } not found. ")
    end
  end
end