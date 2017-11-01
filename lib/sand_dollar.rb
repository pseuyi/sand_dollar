require 'sinatra'
require 'colorize'

# configuration
configure do
  set :port, 1234
  puts "sand dollar server up and running on port #{settings.port}".blue.on_green.blink
end

get '/test' do
  puts 'hello sand dollar'
end

post '/connect' do
  "connected! \npeers: #{params[:peers]} blockchain: #{params[:blockchain]}".red
end

post '/send' do

end

not_found do
  'cannot find ..gurgle..what you are looking for..gurgle'
end
