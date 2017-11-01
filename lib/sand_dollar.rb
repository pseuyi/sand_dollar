require 'sinatra'

# configuration
configure do
  set :port, 1234
end

get '/test' do
  'hello sand dollar'
end

post '/send' do

end

not_found do
  'cannot find ..gurgle..what you are looking for..gurgle'
end
