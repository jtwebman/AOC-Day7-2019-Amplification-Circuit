defmodule ComputerTest do
  use ExUnit.Case

  alias Day7.{Computer, Program, Input}

  test "1,9,10,3,2,3,11,0,99,30,40,50" do
    program = Computer.run(Program.new([1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50], :continue))

    assert program.instructions == [
             3500,
             9,
             10,
             70,
             2,
             3,
             11,
             0,
             99,
             30,
             40,
             50
           ]
  end

  test "1,0,0,0,99" do
    program = Computer.run(Program.new([1, 0, 0, 0, 99], :continue))

    assert program.instructions == [
             2,
             0,
             0,
             0,
             99
           ]
  end

  test "2,3,0,3,99" do
    program = Computer.run(Program.new([2, 3, 0, 3, 99], :continue))

    assert program.instructions == [
             2,
             3,
             0,
             6,
             99
           ]
  end

  test "2,4,4,5,99,0" do
    program = Computer.run(Program.new([2, 4, 4, 5, 99, 0], :continue))

    assert program.instructions == [
             2,
             4,
             4,
             5,
             99,
             9801
           ]
  end

  def run_program_io(instructions, inputs) do
    Program.new(instructions, :once, inputs)
    |> Computer.run()
    |> Program.fetch_output()
  end

  test "3,0,4,0,99" do
    assert run_program_io([3, 0, 4, 0, 99], [2]) == [2]
  end

  test "Day 5 - Part 1" do
    assert run_program_io(Input.day5_input(), [1]) == [7_839_346, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  test "3,9,8,9,10,9,4,9,99,-1,8" do
    assert run_program_io([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], [1]) == [0]
    assert run_program_io([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], [8]) == [1]
  end

  test "3,9,7,9,10,9,4,9,99,-1,8" do
    assert run_program_io([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], [1]) == [1]
    assert run_program_io([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], [8]) == [0]
  end

  test "3,3,1108,-1,8,3,4,3,99" do
    assert run_program_io([3, 3, 1108, -1, 8, 3, 4, 3, 99], [1]) == [0]
    assert run_program_io([3, 3, 1108, -1, 8, 3, 4, 3, 99], [8]) == [1]
  end

  test "3,3,1107,-1,8,3,4,3,99" do
    assert run_program_io([3, 3, 1107, -1, 8, 3, 4, 3, 99], [1]) == [1]
    assert run_program_io([3, 3, 1107, -1, 8, 3, 4, 3, 99], [8]) == [0]
  end

  test "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9" do
    assert run_program_io([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9], [0]) == [0]
    assert run_program_io([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9], [8]) == [1]
  end

  test "3,3,1105,-1,9,1101,0,0,12,4,12,99,1" do
    assert run_program_io([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1], [0]) == [0]
    assert run_program_io([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1], [8]) == [1]
  end

  test "day 5 large part2" do
    input = [
      3,
      21,
      1008,
      21,
      8,
      20,
      1005,
      20,
      22,
      107,
      8,
      21,
      20,
      1006,
      20,
      31,
      1106,
      0,
      36,
      98,
      0,
      0,
      1002,
      21,
      125,
      20,
      4,
      20,
      1105,
      1,
      46,
      104,
      999,
      1105,
      1,
      46,
      1101,
      1000,
      1,
      20,
      4,
      20,
      1105,
      1,
      46,
      98,
      99
    ]

    assert run_program_io(input, [7]) == [999]
    assert run_program_io(input, [8]) == [1000]
    assert run_program_io(input, [9]) == [1001]
  end
end
