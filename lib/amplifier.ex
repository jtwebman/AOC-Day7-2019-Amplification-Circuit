defmodule Day7.Amplifier do
  defstruct [:setting, :program]

  alias Day7.{Program, Computer}

  def new(setting, instructions) do
    %__MODULE__{setting: setting, program: Program.new(instructions, :first, [setting])}
  end

  def run(%__MODULE__{program: program} = amplifier, input) do
    complete_program =
      Program.add_input(program, input)
      |> Computer.run()

    {%{amplifier | program: Program.clear_outputs(complete_program)},
     List.first(complete_program.outputs)}
  end
end
