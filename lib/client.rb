require 'faraday'

class Client
  URL = 'http://localhost'

  def self.connect(port, peers, blockchain)
    begin
      Faraday.post("#{URL}:#{port}/connect", peers: peers, blockchain: blockchain).body
    rescue Faraday::ConnectionFailed => e
      puts "Error: #{e.message}"
    end
  end

  def self.send(port, to, amount)
    Faraday.post("#{URL}:#{port}/send", to: to, amount: amount).body
  end
end
