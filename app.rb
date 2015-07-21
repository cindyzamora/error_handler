require 'sinatra'

get '/' do
  "Hello World"
end

get '/case1' do
   @foo = 'erb'
   erb :index
end

get '/case2' do
  "Hello Case2"
end

get '/case3' do
  "Hello Case3"
end

get '/case4' do
  "Hello Case4"
end

post '/postaction1' do
  params['name']
end

post '/postaction2' do
  params['name']
end

post '/postaction3' do
  params['name']
end

post '/postaction4' do
  params['name']
end
