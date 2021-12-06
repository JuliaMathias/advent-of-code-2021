defmodule Day01.SonarSweep do
  import Day01.Input

  @input input()

  @spec count_increases :: integer
  def count_increases, do: do_count_increases(@input, 0)

  @spec count_window_increases :: integer
  def count_window_increases, do: do_count_window_increases(@input, 0)

  defp do_count_increases([], count), do: count - 1

  defp do_count_increases([head | tail], count) do
    count =
      if List.first(tail) > head do
        count + 1
      else
        count
      end

    do_count_increases(tail, count)
  end

  defp do_count_window_increases([_head | tail] = input, count) do
    if enough_input?(input) do
      count = if window_increase?(input), do: count + 1, else: count

      do_count_window_increases(tail, count)
    else
      count
    end
  end

  defp window_increase?(input) do
    {needed_input, _rest} = Enum.split(input, 4)
    [first, second, third, fourth] = needed_input
    if second + third + fourth > first + second + third, do: true, else: false
  end

  defp enough_input?(input) do
    if Enum.count(input) == 3, do: false, else: true
  end
end
