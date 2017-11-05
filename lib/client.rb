require 'faraday'
require 'colorize'

puts Faraday::VERSION
puts Faraday::default_adapter

class Client
  URL = 'http://localhost'

  def self.connect(port, peers, blockchain)
    begin
      Faraday.post(
        "#{URL}:#{port}/connect",
        peers: peers,
        blockchain: blockchain
      ).body
    rescue Faraday::ConnectionFailed => e
      puts "error: #{e.message}".red
    end
  end

  def self.send(port, peer_port, amount)
    Faraday.post("#{URL}:#{port}/send", peer_port: peer_port, amount: amount).body
  end

  def self.get_key(port)
    Faraday.get("#{URL}:#{port}/key").body
  end
end
