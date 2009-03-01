#
#  Connect to and handle IRC. 
#
module Mini
  class IRC < EventMachine::Connection
    include EventMachine::Protocols::LineText2
    
    attr_accessor :config, :moderators
    cattr_accessor :connection
    
    def initialize(options)
      self.config = OpenStruct.new(options)
      @queue = []
    end
        
    def say(msg, targets = [])
      targets = ['#' + config.channels.first] if targets.blank?
      msg.split("\n").each do |msg| 
        targets.each do |target| 
          command (msg.starts_with?("/") ? msg[1..-1] : "PRIVMSG #{ target.delete("@") } :#{ msg }")
        end
      end
    end
    
    def command(*cmd)
      send_data "#{ cmd.flatten.join(' ') }\r\n"
    end
        
    def queue(sender, receiver, msg)
      @queue << [sender.split("!").first, msg]
      command "NAMES", "#" + config.channels.first
    end

    def dequeue(nicks)
      self.moderators = nicks.split.map { |nick| nick.delete("@").delete("+") }
      
      while job = @queue.pop
        sender, cmd = job
         execute(cmd) if self.moderators.include?(sender)
      end
    end
    
    def execute(cmd)
      say(%x{ miniminimini #{ cmd } })
    end
    
    def self.connect(options)
      self.connection = EM.connect(options[:server], (options[:port] || "6667").to_i, self, options)
    end
    
    # callbacks
    def post_init
      command "USER", [config.user]*4
      command "NICK", config.user
      command("NickServ IDENTIFY", config.user, config.password) if config.password
      config.channels.each { |channel| command("JOIN", "##{ channel }")  } if config.channels
    end
    
    def receive_line(line)
      case line
      when /^PING (.*)/ : command('PONG', $1)
      when /^:(\S+) PRIVMSG (.*) :\?(.*)$/ : queue($1, $2, $3)
      when /^:\S* \d* #{ config.user } @ #{ '#' + config.channels.first } :(.*)/ : dequeue($1)
      else puts line; end
    end
    
    def unbind
      EM.add_timer(3) do
        reconnect(config.server, config.port)
        post_init
      end
    end
  end
end