defmodule Cards do
  @moduledoc """
    Provides methos for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
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

  @doc """
    Determins whether a deck contains a given card

  ## Examples
      iex(1)> deck = Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts",
      "Ace of Diamons", "Two of Diamons", "Three of Diamons",
      "Four of Diamons", "Five of Diamons"]
      iex(2)> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainer of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]

  """
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

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end


# Notes:
# Whenever possible delegate functionality down to existing standard lybrary module functions
#
# :erlang gives us access to Erlang lybraries
#
# :ok and :error are "Atoms". Atoms are constants whose values are their own name.
#
# unused variables are creating a warning in the Elixir shell.
# We can avoid that by using an undescore: {:error, _reason}
#
# there are two ways of testin in Elixir, doctest and test cases.
# doctest has to follow a specific formating, but is also generating documentation.
# Tipp: just copy from console in-/outpu.
