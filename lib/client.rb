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

  def self.send(to, from, amount)
    Faraday.post("#{URL}:#{to}/send", from: from, amount: amount).body
  end

  def self.get_key(port)
    Faraday.get("#{URL}:#{port}/key").body
  end
end

# Client.connect('1234', 'a', 'b')
