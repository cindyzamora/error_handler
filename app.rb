require 'sinatra'

get '/' do
  erb :index
end

post '/postaction1' do
  number = params['number']
  partner = params['service']
  l = number.length
  number = number[l-1,l]
  case number
  when '0'
    @msg = "Error 1"
    erb :error
  when '1'
    @msg = "Error 2"
    erb :error
  when '2'
    @msg = "Error 3"
    erb :error
  else
    @msg = "unknow error"
    erb :error
  end
end
