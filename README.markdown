# a ruby eventmachine bot inspired by richard jones' irccat. interact via netcat, irc or web. 

## installing

    sudo gem install purzelrakete-mini --source=http://gems.github.com
    
create a directory for mini and run the following

    minigen create <your-mini-dir>
    
this creates two files in your mini dir. edit both as you see fit, then add your mini dir to your $PATH inside of your shell's rc file. 

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

run stuff by typing ?command in the main mini channel or by dmsging mini bot. this will invoke minicmd (in your mini dir) with the command as an arg. if you want the script to run a different language (ie php), just change the bang and replace with your own stuff. 

you have to be on the control channel for the script to execute. this is the first channel in your list. 

### via web

post to `hostname:MINI_WEB_PORT/command/MINI_SECRET`. ie: 

    curl -d "netcat, lolcats, pigs, sweaty snout, nixon" http://localhost:2345/echo/dscds789svjskdlvsdz789mkvcjvklsd6
    
of course normally, you'd proxy to startup.com:2345 from something sitting behind :80. Set up ports in minictl in your mini dir. 

you can find `MINI_SECRET` and `MINI_WEB_PORT` inside of the minictl file in your mini directory. 

## configuration

### commands

you can create commands simply by providing your own  minicmd script. ARGV.first is the command, the rest is arguments. mini comes bundled with a ruby based minicmd script which you can extend by adding procs to it:

      Mini::Bot.commands["echo"] = lambda { |*args| puts args }
      
you can also require any mini plugins in there. 

### web callbacks

there is a secret key (see above) wich you can configure inside of minicmd (inside of your mini dir).