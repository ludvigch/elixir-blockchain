defmodule Transaction do
    def new(sender, recipient, amount) when (amount > 0 and sender != nil and recipient != nil) do
        {:transaction, sender, recipient, amount}
    end
    def new(_,_,_), do: :error

    def to_hashlist({:transaction, sender, recipient, amount}) do
        to_charlist(sender) ++ to_charlist(recipient) ++ to_charlist(amount)
    end
    def to_hashlist(_), do: :notatransaction
end