require 'sinatra'
require 'colorize'
require 'yaml'
require_relative 'utils'
require_relative 'pki'
require_relative 'blockchain'

# port args
$PORT, $PEER_PORT, *REST = ARGV
$PEERS = [$PORT]
$PEERS << $PEER_PORT if $PEER_PORT

# global blockchain
$BLOCKCHAIN = nil

# generate my public and private key
PKEY = PKI.generate_key
PUB_KEY = PKEY.public_key.to_s
PRIV_KEY = PKEY.to_s


# configuration
configure :development do
  set :bind, '10.0.1.13'
  set :port, $PORT
  set :show_exceptions, :after_handler
  puts "sand dollar server up and running on port #{settings.port}".blue.on_green.blink
end


# genesis blockchain
$BLOCKCHAIN = Blockchain.new(PUB_KEY, PRIV_KEY) if $PEERS.length <= 1

# primitive logging
count = 0
set_interval(1.5) {

  puts "update ##{count}"

  # connect to peers and update my blockchain
  $PEERS.each do |peer|
    next if peer == $PORT
    response = Client.connect(peer, $PEERS, $BLOCKCHAIN)
    params = YAML.load(response)
    request_peers = params[:peers]
    request_blockchain = params[:blockchain]

    $PEERS = update_peers(request_peers, $PEERS, $PORT)
    $BLOCKCHAIN = update_blockchain(request_blockchain, $BLOCKCHAIN)

    $BLOCKCHAIN.print_ledger
    puts "connected to #{peer.to_s.blue}" unless peer == $PORT
  end

  count += 1
}

get '/test' do
  puts 'hello sand dollar'
end

post '/connect' do
  request_peers = params[:peers]
  $PEERS = update_peers(request_peers, $PEERS, $PORT)
  YAML.dump( peers: $PEERS, blockchain: $BLOCKCHAIN )
end

post '/send' do
  peer_pub_key = Client.get_key(params[:peer_port])
  new_transaction = Transaction.new(
    PUB_KEY,
    peer_pub_key,
    params[:amount],
    PRIV_KEY
  )
  $BLOCKCHAIN.add_block(new_transaction)
  puts "added new block!"
end

get '/key' do
  PUB_KEY
end

not_found do
  puts 'cannot find ..gurgle..what you are looking for..gurgle'
end

error do
  'error: ' + env['sinatra.error'].message
end
