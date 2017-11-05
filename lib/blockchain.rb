require_relative 'block'

class Blockchain

  attr_reader :blocks

  def initialize(pub_key, priv_key)
    @blocks = []
    @blocks << Block.create_genesis_block(pub_key, priv_key)
  end

  def length
    @blocks.length
  end

  def valid?
    @blocks.all? { |b| b.valid? } && balances_valid?
  end

  def add_block(txn)
    blocks << Block.new(blocks.last, txn)
  end

  def calc_balances
    ledger = Hash.new(0)

    ledger[blocks.first.txn.to] += blocks.first.txn.amount.to_i

    blocks.drop(1).each do |block|
      from = block.txn.from
      to = block.txn.to
      amount = block.txn.amount.to_i

      ledger[from] -= amount
      ledger[to] += amount
    end

    ledger
  end

  def print_ledger
    calc_balances.each do |k,v|
      puts "client public key: ".ljust(20).blue + "#{k[-34..-26].chomp}".red
      puts "account balance: ".ljust(20).blue + "#{v}".red
      puts '*' * 30
    end
  end

  private

  def balances_valid?
    # if a balance goes negative, the block is not valid
    !calc_balances.any? { |_, value| value < 0 }
  end
end
