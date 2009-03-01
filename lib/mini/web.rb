@@web = Sinatra.new do
  get("/:command/:secret") do
    Mini::IRC.connection.exececute(["miniweb", params[:command], params.to_yaml].join) if params[:secret] == ENV['MINI_SECRET']
  end
end