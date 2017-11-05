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
  puts "updating blockchain"
  return blockchain unless request_blockchain.valid?

  if blockchain.nil? ||
    request_blockchain.length > blockchain.length

    return request_blockchain
  end

  blockchain
end
