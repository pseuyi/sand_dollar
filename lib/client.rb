require 'faraday'

class Client
  URL = 'http://localhost'

  def self.gossip(port, peers, blockchain)
    begin
      Faraday.post("#{URL}:#{port}/gossip", peers: peers, blockchain: blockchain)
    rescue Faraday::ConnectionFailed => e
      raise
    end
  end

  def self.send_money(port, to, amount)
    Faraday.post("#{URL}:#{port}/send_money", to: to, amount: amount)
  end
end


p Client.send_money(9999, 8888, 300)
