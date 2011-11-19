require 'sinatra'
set :server, :thin
#set :port, 80
set :public_folder, File.dirname(__FILE__) + '/public'


require 'net/http'
require 'uri'


get '/text/*.txt' do  | file |
  url = "http://s3.amazonaws.com/docucloud/pages/text/#{file}.txt"
  resp = Net::HTTP.get_response URI.parse(url)
  resp.body
end

get '/cfg.json' do
  content_type 'application/x-javascript'
  erb :config
end
get '/' do
  erb :index 
end

