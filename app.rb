require 'sinatra'
set :server, :thin
#set :port, 80
set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  erb :index 
end

