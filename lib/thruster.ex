defmodule Day7.Thruster do
  alias Day7.Amplifier

  defstruct [
    :settings,
    :amplifier_a,
    :amplifier_b,
    :amplifier_c,
    :amplifier_d,
    :amplifier_e,
    :mode,
    :last_output
  ]

  def new(
        [settings_a, settings_b, settings_c, settings_d, settings_e] = settings,
        instructions,
        mode
      ) do
    %__MODULE__{
      settings: settings,
      amplifier_a: Amplifier.new(settings_a, instructions),
      amplifier_b: Amplifier.new(settings_b, instructions),
      amplifier_c: Amplifier.new(settings_c, instructions),
      amplifier_d: Amplifier.new(settings_d, instructions),
      amplifier_e: Amplifier.new(settings_e, instructions),
      mode: mode,
      last_output: 0
    }
  end

  def test(%__MODULE__{mode: :once} = thruster) do
    {thruster, last_output} =
      run_amplifier({thruster, 0}, :amplifier_a)
      |> run_amplifier(:amplifier_b)
      |> run_amplifier(:amplifier_c)
      |> run_amplifier(:amplifier_d)
      |> run_amplifier(:amplifier_e)

    %{thruster | last_output: last_output}
  end

  def test(%__MODULE__{mode: :feedback} = thruster) do
    loopback_test(thruster, 0)
  end

  defp loopback_test(thruster, input) do
    {thruster, output} =
      run_loop_amplifier({thruster, input}, :amplifier_a)
      |> run_loop_amplifier(:amplifier_b)
      |> run_loop_amplifier(:amplifier_c)
      |> run_loop_amplifier(:amplifier_d)
      |> run_loop_amplifier(:amplifier_e)

    case output do
      nil -> thruster
      _ -> loopback_test(thruster, output)
    end
  end

  defp run_loop_amplifier({thruster, nil}, _name) do
    {thruster, nil}
  end

  defp run_loop_amplifier({thruster, last_output}, :amplifier_e) do
    {thruster, output} = run_amplifier({thruster, last_output}, :amplifier_e)
    {%{thruster | last_output: output}, output}
  end

  defp run_loop_amplifier({thruster, last_output}, name) do
    run_amplifier({thruster, last_output}, name)
  end

  defp run_amplifier({thruster, input}, name) do
    {amplifier, output} = Map.get(thruster, name) |> Amplifier.run(input)
    {Map.put(thruster, name, amplifier), output}
  end

  def all_permutations(instructions) do
    permutations([0, 1, 2, 3, 4])
    |> Enum.map(&new(&1, instructions, :once))
  end

  def all_permutations(instructions, :once = mode) do
    permutations([0, 1, 2, 3, 4])
    |> Enum.map(&new(&1, instructions, mode))
  end

  def all_permutations(instructions, :feedback = mode) do
    permutations([5, 6, 7, 8, 9])
    |> Enum.map(&new(&1, instructions, mode))
  end

  defp permutations([]), do: [[]]

  defp permutations(list) do
    for elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest]
  end
end
