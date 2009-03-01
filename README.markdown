# a ruby eventmachine bot inspired by richard jones' irccat. interact via netcat, irc or web. 

## installing

    sudo gem install purzelrakete-mini --source=http://gems.github.com
    
## usage

launch: (leave the # off the channel names. you can add many channel names, main one is first)

    minictl irc.freenode.net 6667 my_bot_name my_bot_nickserv_passwd my_bot_control_channel next_channel
    
íf you want to background this, just do something like

    nohup minictl irc.freenode.net 6667 mimi secret mini-lounge &

### via netcat
  
now send some data down the pipes!

    echo "Ilovethistuffs yes .. i .. do. " | nc localhost 12345
    vmstat | nc localhost 12345
    echo "#musicteam,#legal,@alice New album uploaded: ..." | nc somemachine 12345
    tail -f /var/log/important.log | nc somemachine 12345
  
to send IRC commands from the bot, prepend '/':

    echo "/JOIN #some_channel"

### via irc  

run stuff by typing ?command in the main mini channel or by dmsging mini bot. this will invoke a script called miniminimini with the command as an arg. there's a default script bundled as an executable in the gem. if you want to use your own, just make sure you place it before the bundled one in your $PATH. here's an example:

    #!/usr/local/bin/ruby
    puts "called miniminimini with #{ ARGV.inspect }"

don't forget to chmod +x and replace the bang as appropriate. 

you have to be on the control channel for the script to execute. this is the first channel in your list. 

### via web

post to hostname:MINI_WEB_PORT/MINI_SECRET/command. ie: 

    curl -dtext="netcat, lolcats, pigs, sweaty snout, nixon!" http://test.com:2345/dscds789svjskdlvsdz789mkvcjvklsd6/echo
    
of course normally, you'd proxy to startup.com:2345 from somthing sitting behind :80. Set the ENV variables before starting mini. 

## commands

you can create commands simply by providing your own miniminimini script. ARGV.first ist the command, the rest is arguments. mini comes bundled with a ruby based miniminimini script which you can extend by adding procs like this: 

      Mini::Web.commands[:echo] = lambda { |*args| puts args }

## configuration

the following environment variables can be used to configure mini. 

* `MINI_SECRET`: a secret key for the web server, ie /kvds78ovdsjhvksd7ckjlds7cvds879bskdl/git_commit
* `MINI_CAT_PORT`: port for clients using netcat. 
* `MINI_WEB_PORT`: port on which the web server is started. 