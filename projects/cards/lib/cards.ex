defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamons"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
        {:ok, binary} -> :erlang.binary_to_term binary
        {:error, _reason} -> "That file does not exist"
    end
  end
end


# Notes:
# Whenever possible delegate functionality down to existing standard lybrary module functions
# :erlang gives us access to Erlang lybraries
# :ok and :error are "Atoms". Atoms are constants whose values are their own name.
# unused variables are creating a warning in the Elixir shell. We can avoid that by using an undescore: {:error, _reason}
