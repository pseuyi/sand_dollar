require 'sinatra'
require 'colorize'
require_relative 'utils'

# configuration
configure do
  set :port, 1234
  puts "sand dollar server up and running on port #{settings.port}".blue.on_green.blink
end

# primitive logging
count = 0
set_interval(3) { puts "updated #{count} time(s)"; count +=1 }

get '/test' do
  puts 'hello sand dollar'
end

post '/connect' do
  puts "#{params[:name]} connected! \npeers: #{params[:peers]} blockchain: #{params[:blockchain]}".red
end

post '/send' do

end

not_found do
  puts 'cannot find ..gurgle..what you are looking for..gurgle'
end
