# a ruby eventmachine bot inspired by richard jones' irccat. also logs channels. history and webhooks via sinatra. 

## usage

launch like this. note - leave the # off the channel names. you can add many channel names, main one is first. 

  ruby script/mini.rb irc.freenode.net 6667 my_bot_name my_bot_nickserv_passwd my_bot_control_channel next_channel
  
now send some data down the pipes!

  echo "Ilovethistuffs yes .. i .. do. " | nc localhost 12345
  vmstat | nc localhost 12345
  echo "#musicteam,#legal,@alice New album uploaded: ..." | nc somemachine 12345
  tail -f /var/log/important.log | nc somemachine 12345
  
to send IRC commands, prepend '/':

  echo "/JOIN #some_channel"
  
run stuff by typing ?command in the main mini channel or by dmsging mini bot. this will invoke a script called miniminimini with the command as an arg. here's an example miniminimini:

  #!/usr/local/bin/ruby

  puts "called miniminimini with #{ ARGV.inspect }"

place this on your $PATH and don't forget to chmod +x. check where ruby lives by typing `which ruby`, and replace the bang line above with your ruby path. 

you have to be on the control channel for the script to execute. this is the first channel in your list. 