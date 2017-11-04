require 'sinatra'
require 'colorize'
require_relative 'utils'

PORT, PEER_PORT, *REST = ARGV

# configuration
configure :development do
  set :port, PORT
  set :show_exceptions, :after_handler
  puts "sand dollar server up and running on port #{settings.port}".blue.on_green.blink
end

# primitive logging
count = 0
set_interval(3) { puts "updated #{count} time(s)"; count +=1 }

get '/test' do
  puts 'hello sand dollar'
end

post '/connect' do
  puts "#{params[:name]} connected! \npeers: #{params[:peers]} blockchain: #{params[:blockchain]}".green
end

post '/send' do

end

not_found do
  puts 'cannot find ..gurgle..what you are looking for..gurgle'
end

error do
  'error: ' + env['sinatra.error'].message
end
