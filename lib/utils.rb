require_relative 'client'

def set_interval(interval)
  Thread.new do
    loop do
      sleep interval
      yield
    end
  end
end


def update_peers(request_peers, peers, port)
  (peers + request_peers).uniq.reject { |peer| peer == port }
end

def update_blockchain(request_blockchain, blockchain)
  return blockchain unless request_blockchain.valid?

  if blockchain.nil? ||
    request_blockchain.length > blockchain.length

    return request_blockchain
  end

  blockchain
end



# def update_blockchain_from_peers(peers, blockchain)
#   peers.each do |peer|
#     response = Client.connect(peer, peers, blockchain)
#     response = JSON.parse(response)
#     puts "connected to #{peer.to_s.blue}" unless peer == PORT
#   end
# end
