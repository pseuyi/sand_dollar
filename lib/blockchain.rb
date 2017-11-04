require_relative 'block'

class BlockChain

  def initialize(pub_key, priv_key)
    @blocks = []
    @blocks << Block.create_genesis_block(pub_key, priv_key)
  end

end
