defmodule Block do
    
    # block data structure represented as a tuple:
    # {:block, index, prev_hash, proof, timestamp, transactions}
    # block() :: {:block, int(), binary(), int(), int(), list()}

    def new(index, prev_hash, proof, transactions) when (index != nil 
                                                                 and proof != nil 
                                                                 and prev_hash != nil 
                                                                 and transactions != nil) do
        {:block, index, prev_hash, proof, :os.system_time()/1000000000, transactions}
    end
    def new(_,_,_,_), do: :error

    def to_list({:block, i, p, pr, t, tr}) do
        [:block, i, p, pr, t, tr]
    end
    def to_list(_), do: :notablock
end