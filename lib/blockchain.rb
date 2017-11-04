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
    @blocks.all? { |b| b.valid? }
  end
end
