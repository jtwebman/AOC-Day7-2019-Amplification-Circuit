defmodule Day7 do
  alias Day7.{Thruster, Input}

  def run() do
    Input.input()
    |> run(:feedback)
  end

  def run_part1() do
    Input.input()
    |> run(:once)
  end

  def run(input, mode) do
    input
    |> Thruster.all_permutations(mode)
    |> Enum.map(&Thruster.test/1)
    |> Enum.max_by(fn t -> t.last_output end)
  end
end
