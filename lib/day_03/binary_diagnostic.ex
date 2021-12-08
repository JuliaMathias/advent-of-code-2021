defmodule Day03.BinaryDiagnostic do
  import Day03.Input

  @input input()

  # @input ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]

  def diagnose do
    gamma = gamma(@input)
    epsilon = epsilon(@input)

    gamma * epsilon
  end

  defp gamma(input) do
    first_digit = check_column(input, 0, :gamma)

    check_column_and_add(input, 1, [first_digit], :gamma) |> to_decimal()
  end

  defp epsilon(input) do
    first_digit = check_column(input, 0, :epsilon)

    check_column_and_add(input, 1, [first_digit], :epsilon) |> to_decimal()
  end

  defp check_column(input, index, rate_type) do
    map = generate_frequencies_map(input, index)

    case rate_type do
      :gamma -> return_bigger(map)
      :epsilon -> return_smaller(map)
    end
  end

  defp check_column_and_add(input, 11, digits_list, rate_type) do
    digits_list ++ [check_column(input, 11, rate_type)]
  end

  defp check_column_and_add(input, index, digits_list, rate_type) do
    new_digits_list = digits_list ++ [check_column(input, index, rate_type)]

    check_column_and_add(@input, index + 1, new_digits_list, rate_type)
  end

  defp return_bigger(frequencies) do
    if frequencies[0] > frequencies[1], do: 0, else: 1
  end

  defp return_smaller(frequencies) do
    if frequencies[0] < frequencies[1], do: 0, else: 1
  end

  defp generate_frequencies_map(input, index) do
    input
    |> Enum.into([], fn tuple -> elem(tuple, index) end)
    |> Enum.frequencies()
  end

  defp to_decimal(input) do
    IO.inspect(binding(),
      label: "binding() #{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}",
      limit: :infinity
    )

    input
    |> Enum.join()
    |> String.to_integer(2)
  end
end
