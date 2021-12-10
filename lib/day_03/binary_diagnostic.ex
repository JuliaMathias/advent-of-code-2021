defmodule Day03.BinaryDiagnostic do
  import Day03.Input

  @input input()

  # @input [
  #   {0, 0, 1, 0, 0},
  #   {1, 1, 1, 1, 0},
  #   {1, 0, 1, 1, 0},
  #   {1, 0, 1, 1, 1},
  #   {1, 0, 1, 0, 1},
  #   {0, 1, 1, 1, 1},
  #   {0, 0, 1, 1, 1},
  #   {1, 1, 1, 0, 0},
  #   {1, 0, 0, 0, 0},
  #   {1, 1, 0, 0, 1},
  #   {0, 0, 0, 1, 0},
  #   {0, 1, 0, 1, 0}
  # ]

  def diagnose do
    gamma = gamma(@input)
    epsilon = epsilon(@input)

    gamma * epsilon
  end

  def calculate_life_support do
    oxygen_generator_rating = calculate_rating(@input, :gamma) |> IO.inspect()
    co2_scrubber_rating = calculate_rating(@input, :epsilon) |> IO.inspect()

    oxygen_generator_rating * co2_scrubber_rating
  end

  defp calculate_rating(input, type),
    do: do_calculate_rating(input, 0, type)

  defp do_calculate_rating(input, _index, _type) when length(input) == 1,
    do: Enum.fetch!(input, 0) |> Tuple.to_list() |> to_decimal()

  defp do_calculate_rating(input, index, type) do
    digit = check_column(input, index, type)

    new_input = Enum.filter(input, fn tuple -> elem(tuple, index) == digit end)

    IO.inspect(new_input)

    do_calculate_rating(new_input, index + 1, type)
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
      :gamma -> return_bigger(map) |> IO.inspect()
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
    if frequencies[0] > frequencies[1], do: 1, else: 0
  end

  defp generate_frequencies_map(input, index) do
    input
    |> Enum.into([], fn tuple -> elem(tuple, index) end)
    |> Enum.frequencies()
  end

  defp to_decimal(input) do
    input
    |> Enum.join()
    |> String.to_integer(2)
  end
end
