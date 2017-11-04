require 'faraday'

puts Faraday::VERSION
puts Faraday::default_adapter

class Client
  URL = 'http://localhost'

  def self.connect(port, peers, blockchain)
    begin
      Faraday.post("#{URL}:#{port}/connect", peers: peers, blockchain: blockchain)
    rescue Faraday::ConnectionFailed => e
      puts "Error: #{e.message}"
    end
  end

  def self.send(port, to, amount)
    Faraday.post("#{URL}:#{port}/send", to: to, amount: amount).body
  end
end

Client.connect('1234', 'a', 'b')
