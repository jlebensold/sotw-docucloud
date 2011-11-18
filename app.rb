require 'sinatra'
set :server, :thin
set :port, 80
get '/' do
  "hello"
end

