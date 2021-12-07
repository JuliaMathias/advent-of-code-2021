defmodule Day02.Dive do
  import Day02.Input

  @input input()

  # @input ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]

  def submerge do
    directions = get_directions(@input)

    horizontal_position = sum(directions, :forward)
    depth = sum(directions, :down) - sum(directions, :up)

    horizontal_position * depth
  end

  def aim do
    @input
    |> get_directions()
    |> do_aim(0, 0, 0)
  end

  defp parse(instruction) do
    [direction, distance] = String.split(instruction)

    [{String.to_atom(direction), String.to_integer(distance)}]
  end

  defp get_directions(input) do
    input
    |> Enum.map(fn x -> parse(x) end)
    |> List.flatten()
  end

  defp sum(directions, keyword) do
    directions
    |> Keyword.get_values(keyword)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  defp do_aim([], horizontal_position, _aim, depth), do: horizontal_position * depth

  defp do_aim([head | tail], horizontal_position, aim, depth) do
    {direction, distance} = head

    case direction do
      :forward -> do_aim(tail, horizontal_position + distance, aim, depth + distance * aim)
      :up -> do_aim(tail, horizontal_position, aim - distance, depth)
      :down -> do_aim(tail, horizontal_position, aim + distance, depth)
    end
  end
end
