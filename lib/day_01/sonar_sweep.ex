defmodule Day01.SonarSweep do
  import Day01.Input

  @input input()

  def count_increases, do: do_count_increases(@input, 0)

  @spec do_count_increases(list, any) :: any
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
end
