require 'digest'
require_relative 'pki'

# from - pub_key of sender
# to - pub_key of receiver
# amount - $ being transferred
# priv_key - private key of sender

class Transaction

  attr_reader :from, :to, :amount

  def initialize(from, to, amount, priv_key)
    @from, @to, @amount = from, to, amount
    @signature = PKI.sign(message, priv_key)
  end

  def is_signed_correctly?
    return true if is_genesis_txn?
    #check signature
    PKI.is_valid_signature?(message, @signature, from)
  end

  def is_genesis_txn?
    from.nil?
  end

  def message
    Digest::SHA256.hexdigest([from, to, amount].join)
  end

  def to_s
    message
  end

end
