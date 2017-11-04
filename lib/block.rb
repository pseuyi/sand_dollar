require 'colorize'
require 'digest'

class Block

  attr_reader :own_hash

  NUM_ZEROS = 4

  def self.create_genesis_block(pub_key, priv_key)
    txn = Transaction.new(nil, pub_key, 100, priv_key)
    Block.new(nil, txn)
  end

  def initialize(prev_block, txn)
    raise TypeError unless txn.is_a?(Transaction)
    @txn = txn
    @prev_block_hash = prev_block.own_hash if prev_block
    mine_block!
  end

  def mine_block!
    @nonce = calc_nonce
    @own_hash = hash(full_block(@nonce))
  end

  def to_s
    puts [
      "previous hash: ".ljust(20).blue + @prev_block_hash.to_s.red,
      "message: ".ljust(20).blue + @txn.to_s.red,
      "nonce: ".ljust(20).blue + @nonce.red,
      "own hash: ".ljust(20).blue + @own_hash.red
    ].join("\n")
  end

  private

    def hash(content)
      Digest::SHA256.hexdigest(content)
    end

    def calc_nonce
      nonce = 'INITIAL SAND DOLLAR NONCE'
      count = 0
      print 'loading'

      while !is_valid_nonce?(nonce)
        print '.' if count % 1000 == 0
        nonce = nonce.next
        count += 1
      end

      nonce
    end

    def is_valid_nonce?(nonce)
      hash(full_block(nonce)).start_with?('0' * NUM_ZEROS)
    end

    def full_block(nonce)
      [@txn.to_s, @prev_block_hash, nonce].compact.join # compact gets rid of nil values
    end
end

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


class BlockChain

  def initialize(pub_key, priv_key)
    @blocks = []
    @blocks << Block.create_genesis_block(pub_key, priv_key)
  end

end
