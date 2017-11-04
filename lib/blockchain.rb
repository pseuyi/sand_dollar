require_relative 'block'

class Blockchain

  def initialize(pub_key, priv_key)
    @blocks = []
    @blocks << Block.create_genesis_block(pub_key, priv_key)
  end

  def length
    @blocks.length
  end

  def valid?
    @blocks.all(&:valid?)
  end
end
