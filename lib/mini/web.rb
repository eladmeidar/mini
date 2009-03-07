@@web = Sinatra.new do
  post("/:command/:secret") do
    command, secret = params.delete("command"), params.delete("secret")
    Mini::IRC.connection.execute([command, params].join(" ")) if secret == Mini::Bot.secret
  end
end