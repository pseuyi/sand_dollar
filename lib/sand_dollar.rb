require 'sinatra'
require 'colorize'
require 'yaml'
require_relative 'utils'
require_relative 'pki'
require_relative 'blockchain'

# port args
$PORT, $PEER_PORT, *REST = ARGV
$PEERS = []
$PEERS << $PEER_PORT if $PEER_PORT

# global blockchain
$BLOCKCHAIN = nil

# configuration
configure :development do
  set :port, $PORT
  set :show_exceptions, :after_handler
  puts "sand dollar server up and running on port #{settings.port}".blue.on_green.blink
end

# generate my public and private key
pkey = PKI.generate_key
my_pub_key = pkey.public_key.to_s
my_priv_key = pkey.to_s

if $PEERS.empty?
  $BLOCKCHAIN = Blockchain.new(my_pub_key, my_priv_key)
end

# primitive logging
count = 0
set_interval(3) {

  # send my blockchain to peers


  puts "update ##{count}"

  $PEERS.each do |peer|
    response = Client.connect(peer, $PEERS, $BLOCKCHAIN)
    params = YAML.load(response)
    request_peers = params[:peers]
    request_blockchain = params[:blockchain]

    update_peers(request_peers, $PEERS, $PORT)
    $BLOCKCHAIN = update_blockchain(request_blockchain, $BLOCKCHAIN)

    puts "connected to #{peer.to_s.blue}" unless peer == $PORT
  end

  count += 1
}

get '/test' do
  puts 'hello sand dollar'
end

post '/connect' do
  #$PEERS << params[:peers]
  # send my blockchain
  # puts "#{params[:name]} connected! \npeers: #{params[:peers]} blockchain: #{params[:blockchain]}".green

  # request_peers = JSON.parse(params[:peers])
  # request_blockchain = JSON.parse(params[:blockchain])
  # update_peers(request_peers)
  # update_blockchain(request_blockchain)

  YAML.dump( peers: $PEERS, blockchain: $BLOCKCHAIN )
end

post '/send' do

end

not_found do
  puts 'cannot find ..gurgle..what you are looking for..gurgle'
end

error do
  'error: ' + env['sinatra.error'].message
end
