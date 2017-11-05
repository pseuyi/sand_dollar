require 'openssl'
require 'base64'

class PKI

  def self.generate_key
    OpenSSL::PKey::RSA.new(2048)
  end

  def self.sign(message, priv_key)
    priv_key = OpenSSL::Pkey::RSA.new(priv_key)
    encrypted_msg = priv_key.private_encrypt(message)
    Base64.encode(encrypted_msg)
  end

end
