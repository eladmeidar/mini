module Mini
  module Listener

    # echo "#musicteam,#legal,@alice New album uploaded: ..." | nc somemachine 12345.
    def receive_data(data)
      all, targets, *payload = *data.match(/^(([\#@]\S+,? ?)*)(.*)$/)
      targets = targets.split(",").map { |target| target.strip }.uniq
      
      IRC.connection.say(payload.pop.strip, targets)
    end
  end
end