defmodule BitcoinAccounting.GetBookEntries do
  @execute_defaults %{empty_address_count: 20}

  alias BitcoinAccounting.GetBlockEntries.TradeSummary

  @spec from_xpub(binary(), list()) :: list()
  def from_xpub(xpub, opts \\ []) do
    %{empty_address_count: empty_address_count} = Enum.into(opts, @execute_defaults)

    %{
      change: change_entries,
      receive: receive_entries
    } = BitcoinAccounting.get_book_entries(xpub, gap_limit_stop: empty_address_count)

    receive_entries = flatten(receive_entries, :receive)
    change_entries = flatten(change_entries, :change)

    (receive_entries ++ change_entries)
    |> TradeSummary.from_entries()
  end

  defp flatten(entries, receive_or_change) do
    entries
    |> Enum.map(fn entry -> to_new_structure(entry, receive_or_change) end)
    |> Enum.concat()
  end

  defp to_new_structure(entry, receive_or_change) do
    entry.history
    |> Enum.map(fn history ->
      history
      |> Map.put(:type, receive_or_change)
      |> Map.put(:address, entry.address)
    end)
  end
end
