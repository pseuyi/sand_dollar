require 'sinatra'
require 'colorize'
require_relative 'utils'
require_relative 'pki'

# port args
PORT, NETWORK, *REST = ARGV
PEERS = [PORT]
PEERS << NETWORK unless NETWORK.nil?

# configuration
configure :development do
  set :port, PORT
  set :show_exceptions, :after_handler
  puts "sand dollar server up and running on port #{settings.port}".blue.on_green.blink
end

# primitive logging
count = 0
set_interval(3) {
  puts "update ##{count}"
  PEERS.each do |peer|
    puts "connected to #{peer.to_s.blue}" unless peer == PORT
  end
  count += 1
}

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
