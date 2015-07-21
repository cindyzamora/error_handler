require 'sinatra'
require_relative 'errors/errors'
get '/' do
  erb :index
end

post '/postaction1' do
  number = params['number']
  partner = params['service']
  l = number.length
  number = number[l-1,l]
  hash = Error.new.read number
  @msg = hash[:message]
  erb :error
end
