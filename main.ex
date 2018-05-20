defmodule Main do
    def start() do
        genesis = Block.new(1, 1, 100, [])
        chain = spawn_link(fn -> Blockchain.blockchain([genesis], []) end)
        send(chain, {:mine, 13})
        send(chain, {:mine, 13})
        send(chain, {:chain, self()})
        receive do
            x -> x
        end
    end

    # 1. genesis block for chain
    # 2. 
end