require 'openssl'

class PKI
  def self.generate_key
    OpenSSL::PKey::RSA.new(2048)
  end
end
