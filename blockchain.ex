defmodule Blockchain do
    def blockchain(chain, current_transactions, index) do
        receive do
            {:add_trans, transaction} -> blockchain(chain, [transaction | current_transactions])
            {:mine, address} -> 
        end
        
    end

    def hash(block = {:block, index, prev_hash, proof, timestamp, transactions}) do
        x = to_charlist(index) ++ to_charlist(prev_hash) ++ 
            to_charlist(proof) ++ to_charlist(timestamp)
        cont = :crypto.hash_init(:sha256)
        hash(:crypto.hash_update(cont, x), transactions)
    end
    defp hash(context, []) do
        :crypto.hash_final(context)
    end
    defp hash(context, [h|t]) do
        hash(:crypto.hash_update(context, Transaction.to_hashlist(h)), t)
    end
end