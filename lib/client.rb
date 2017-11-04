require 'faraday'
require 'colorize'

puts Faraday::VERSION
puts Faraday::default_adapter

class Client
  URL = 'http://localhost'

  def self.connect(port, name, peers, blockchain)
    begin
      Faraday.post("#{URL}:#{port}/connect", name: name, peers: peers, blockchain: blockchain).body
    rescue Faraday::ConnectionFailed => e
      puts "Error: #{e.message}".red
    end
  end

  def self.send(port, to, amount)
    Faraday.post("#{URL}:#{port}/send", to: to, amount: amount).body
  end
end

Client.connect('1234', 'freda', 'a', 'b')
