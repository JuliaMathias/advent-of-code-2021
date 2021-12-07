defmodule Day02.Dive do
  import Day02.Input

  @input input()

  # @input ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]

  def submerge do
    directions =
      @input
      |> Enum.map(fn x -> parse(x) end)
      |> List.flatten()

    horizontal_position = sum(directions, :forward)
    depth = sum(directions, :down) - sum(directions, :up)

    horizontal_position * depth
  end

  defp parse(instruction) do
    [direction, distance] = String.split(instruction)

    [{String.to_atom(direction), String.to_integer(distance)}]
  end

  defp sum(directions, keyword) do
    directions
    |> Keyword.get_values(keyword)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end
end
