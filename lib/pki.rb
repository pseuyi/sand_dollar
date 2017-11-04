require 'openssl'

class PKI
  def self.generate_key
    key_pair = OpenSSL::PKey::RSA.new(2048)
  end
end
