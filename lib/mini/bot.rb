#
#  Runs proc stored in Mini::Bot.commands[command].
#
module Mini
  class Bot
    cattr_accessor :commands
    @@commands = {}
    
    def self.run(command, args)
      proc = Bot.commands[command]
      proc ? proc.call(args) : (puts "command #{ command } not found. ")
    end
  end
end