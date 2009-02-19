#
#  Connect to and handle IRC. 
#
module Mini
  class IRC < EventMachine::Connection
    
    include EventMachine::Protocols::LineText2
    cattr_accessor *(@@config = [:user, :password, :server, :port, :channels])
    
    def say(msg, targets = [])
      targets = ['#' + IRC.channels.first] if targets.blank?
      msg.split("\n").each do |msg| 
        targets.each { |target| command "PRIVMSG #{ target.delete("@") } :#{ msg }" }
      end
    end
    
    def command(*cmd)
      send_data "#{ cmd.flatten.join(' ') }\r\n"
    end
        
    def execute(sender, receiver, msg)
      (@queue ||= []) << [sender, receiver, msg]
      command "NAMES", "#" + IRC.channels.first
    end

    def self.connect(options)
      @@config.each { |param| IRC.send("#{ param }=", options[param]) }
      EM.connect(IRC.server, IRC.port, self, options)
    end
    
    #
    #  Callbacks
    #
    
    def post_init
      command "USER", [IRC.user]*4
      command "NICK", IRC.user
      command("NickServ IDENTIFY", IRC.user, IRC.password) if IRC.password
      IRC.channels.each { |channel| command("JOIN", "##{ channel }")  } if IRC.channels
    end
    
    def receive_line(line)
      case line
      when /^PING (.*)/ : command('PONG', $1)
      when /^:(\S+) PRIVMSG (.*) :\!(.*)$/ : execute($1, $2, $3)
      when /^:NAMES / : unwind(nicks)
      else puts line; end
    end
    
    def unbind
      EM.add_timer(3) do
        reconnect(IRC.server, IRC.port)
        post_init
      end
    end
  end
end

__END__
:hubbard.freenode.net 353 dslkfjlds @ #eventmachine :+dslkfjlds +joseferr +yakischloba +rsimon +alloy +Aria +mchung +dj2 +takiuchi_ +elven +elliottcable @raggi +tmm1 +igrigorik +manveru +SuttoL @ChanServ +wyhaines +garbagecat 