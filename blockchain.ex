defmodule Blockchain do
    def blockchain(chain=[h|_t], current_transactions) do
        receive do
            {:add_trans, transaction} -> blockchain(chain, [transaction | current_transactions])
            {:mine, address} -> {:block, i, prev_hash, last_proof, _, _} = h
                                proof = proof_of_work(last_proof)
                                trans = Transaction.new(0, address, 1)
                                blockchain([Block.new(
                                                i+1,
                                                hash(h),
                                                proof,
                                                [trans|current_transactions]) | chain], [])
            {:chain, from} -> send(from, {:chain, chain})
            {:transactions, from} -> send(from, {:transactions, current_transactions})
        end
    end

    def hash({:block, index, prev_hash, proof, timestamp, transactions}) do
        x = to_charlist(index) ++ to_charlist(prev_hash) ++ 
            to_charlist(proof) ++ to_charlist(timestamp)
        cont = :crypto.hash_init(:sha256)
        hash(:crypto.hash_update(cont, x), transactions)
    end
    defp hash(context, []) do
        :crypto.hash_final(context) |> Base.encode16
    end
    defp hash(context, [h|t]) do
        hash(:crypto.hash_update(context, Transaction.to_hashlist(h)), t)
    end

    def proof_of_work(last_proof) do
        proof_of_work(last_proof, 0)
    end
    def proof_of_work(last_proof, i) do
        case valid_proof(last_proof, i) do
            True -> i
            False -> proof_of_work(last_proof, i+1)
        end
    end

    def valid_proof(last_proof, proof) do
        # test if hash(pp') has four leading zeroes as PoW
        case :crypto.hash(:sha256, to_charlist(last_proof) ++ to_charlist(proof)) 
             |> Base.encode16 
             |> String.slice(-4..-1) do
                "0000" -> True
                _ -> False
        end
    end
end