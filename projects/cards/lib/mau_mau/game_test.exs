defmodule MauMau.GameTest do
  use ExUnit.Case
  doctest MauMau.Game

  test "new game creates proper structure" do
    players = ["Player1", "Player2"]
    game = MauMau.Game.new_game(players)

    assert game.players == players
    assert map_size(game.hands) == 2
    assert length(game.hands["Player1"]) == 5
    assert length(game.hands["Player2"]) == 5
    assert length(game.draw_pile) > 0
    assert length(game.discard_pile) == 1
    assert game.current_player == "Player1"
    assert game.winner == nil
  end

  test "fails with less than 2 players" do
    assert_raise FunctionClauseError, fn ->
      MauMau.Game.new_game(["Player1"])
    end
  end
end
