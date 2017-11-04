require 'digest'

class Transaction

  attr_reader :from, :to, :amount

  def initialize(from, to, amount, priv_key)
    @from, @to, @amount = from, to, amount
    #@signature = priv_key
  end

  def is_valid_signature?
    return true if is_genesis_txn?
    #check signature
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
