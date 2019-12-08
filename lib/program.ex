defmodule Day7.Program do
  use Bitwise

  defstruct [:instructions, :pos, :inputs, :outputs, :mode]

  def new(instructions, mode) do
    %__MODULE__{instructions: instructions, pos: 0, inputs: [], outputs: [], mode: mode}
  end

  def new(instructions, mode, inputs) do
    %__MODULE__{instructions: instructions, pos: 0, inputs: inputs, outputs: [], mode: mode}
  end

  def move(%__MODULE__{pos: pos} = program, offset) do
    %{program | pos: pos + offset}
  end

  def move_to(%__MODULE__{} = program, pos) do
    %{program | pos: pos}
  end

  def write(%__MODULE__{instructions: instructions} = program, at, value) do
    %{
      program
      | instructions:
          List.replace_at(
            instructions,
            at,
            value
          )
    }
  end

  def read(%__MODULE__{instructions: instructions, pos: pos}) do
    Enum.at(instructions, pos)
  end

  def read(%__MODULE__{instructions: instructions, pos: pos}, offset) do
    Enum.at(instructions, pos + offset)
  end

  def read(%__MODULE__{instructions: instructions, pos: pos}, offset, param_modes) do
    offset_bit = 1 <<< (offset - 1)

    case band(param_modes, offset_bit) == offset_bit do
      true ->
        Enum.at(instructions, pos + offset)

      _ ->
        Enum.at(instructions, Enum.at(instructions, pos + offset))
    end
  end

  def add_input(%__MODULE__{inputs: inputs} = program, input) do
    %{program | inputs: inputs ++ [input]}
  end

  def fetch_input(%__MODULE__{inputs: [next | rest]} = program) do
    {%{program | inputs: rest}, next}
  end

  def fetch_input(%__MODULE__{inputs: []} = program) do
    {program, nil}
  end

  def add_output(%__MODULE__{outputs: outputs} = program, output) do
    %{program | outputs: [output] ++ outputs}
  end

  def fetch_output(%__MODULE__{outputs: outputs}) do
    outputs
  end

  def clear_outputs(%__MODULE__{} = program) do
    %{program | outputs: []}
  end
end
