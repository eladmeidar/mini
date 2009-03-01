#
#  Runs proc stored in Mini::Bot.commands[command].
#
module Mini
  class Bot
    cattr_accessor :commands
    @@commands = {}
    
    def self.run(command, args)
      proc = Bot.commands[command]
      proc.call(args) if proc
    end
  end
end