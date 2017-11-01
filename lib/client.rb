require 'faraday'

class Client
  URL = 'http://localhost'

  def self.connect(port, peers, blockchain)
    Faraday.post("#{URL}:#{port}/connect", peers: peers, blockchain: blockchain)
  end

  def self.send(port, to, amount)
    Faraday.post("#{URL}:#{port}/send", to: to, amount: amount)
  end
end
