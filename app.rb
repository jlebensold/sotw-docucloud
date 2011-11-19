require 'sinatra'
set :server, :thin
#set :port, 80
set :public_folder, File.dirname(__FILE__) + '/public'


require 'pp'

get '/text/*.txt' do  | file |
  path = File.dirname(__FILE__) +"/text/#{file}.txt"
  IO.readlines(path)
end
get '/search.json/:query' do
  content_type 'application/json'
  results = []
  query = params[:query].to_s
  Dir.glob(File.dirname(__FILE__) + "/text/*.txt").each_with_index { |f,i| 
    str = IO.readlines(f).to_s
    page =  /[0-9].+/.match(f).to_s.split("_").last().split(".").first()
    words = str.gsub(".","").gsub("!","").gsub("?","").gsub(",","").downcase.split(" ")
    if (words.include? query.downcase)
    #if(/#{query}/i.match(str))
      results << page.to_i
    end
  }
  "{\"results\" : #{results},\"query\": \"#{query}\"}"
end

get '/cfg.json' do
  content_type 'application/x-javascript'
  erb :config
end
get '/' do
  erb :index 
end

