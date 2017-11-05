require 'openssl'
require 'base64'

class PKI

  def self.generate_key
    OpenSSL::PKey::RSA.new(2048)
  end

  def self.sign(message, priv_key)
    priv_key = OpenSSL::PKey::RSA.new(priv_key)
    encrypted_msg = priv_key.private_encrypt(message)
    Base64.encode64(encrypted_msg)
  end

  def self.is_valid_signature?(message, signature, from)
    #decrypting signature with sender pub key (from) should equal message
    decrypted_signature(signature, from) == message
  end

  def self.decrypted_signature(signature, from)
    pub_key = OpenSSL::PKey::RSA.new(from)
    pub_key.public_decrypt(Base64.decode64(signature))
  end
end
