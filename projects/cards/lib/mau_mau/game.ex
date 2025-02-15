defmodule MauMau.Game do
  @moduledoc """
  Implements the core game logic for Mau Mau card game.
  Manages game state including players, hands, draw pile, and discard pile.
  """

  @enforce_keys [:players, :hands, :draw_pile, :discard_pile, :current_player]
  defstruct [:players, :hands, :draw_pile, :discard_pile, :current_player, winner: nil]

  @initial_cards 5  # Number of cards each player gets at start

  @doc """
  Creates a new game with the given players.
  Deals #{@initial_cards} cards to each player and sets up the initial game state.

  ## Examples

      iex> game = MauMau.Game.new_game(["Player1", "Player2"])
      iex> length(game.players)
      2
      iex> map_size(game.hands)
      2
      iex> length(game.hands["Player1"])
      5
      iex> length(game.discard_pile)
      1
  """
  def new_game(players) when length(players) >= 2 do
    # Create and shuffle a new deck
    deck = Cards.create_deck() |> Cards.shuffle()

    # Deal hands to each player
    {hands, remaining_cards} = deal_initial_hands(players, deck)

    # Split remaining cards into draw pile and first discard
    [first_discard | draw_pile] = remaining_cards

    # Create the initial game state
    %MauMau.Game{
      players: players,
      hands: hands,
      draw_pile: draw_pile,
      discard_pile: [first_discard],
      current_player: List.first(players)
    }
  end

  @doc """
  Helper function to deal initial hands to all players.
  Returns a tuple of {hands_map, remaining_cards}.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hands, remaining} = MauMau.Game.deal_initial_hands(["P1", "P2"], deck)
      iex> map_size(hands)
      2
      iex> length(hands["P1"])
      5
  """
  def deal_initial_hands(players, deck) do
    # Create a map of player hands
    hands = Enum.reduce(players, {%{}, deck}, fn player, {hands, current_deck} ->
      {hand, rest} = Cards.deal(current_deck, @initial_cards)
      {Map.put(hands, player, hand), rest}
    end)

    # Return tuple of {hands_map, remaining_cards}
    {elem(hands, 0), elem(hands, 1)}
  end
end
