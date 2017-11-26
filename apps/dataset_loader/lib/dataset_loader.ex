defmodule DatasetLoader do
  @moduledoc """
  Load Dateset.
  """

  def load(filepath) do
    # TODO::support any extension file

    # load csv data
    File.stream!(filepath)
    |> CSV.decode
    |> Enum.to_list
    |> Enum.filter(fn x -> :ok == elem(x, 0) end)
    |> Enum.map(fn x -> elem(x, 1) end)
    |> Enum.map(fn x -> x
                        |> Enum.map(fn y -> String.strip(y) end)
                        |> Enum.map(fn y -> elem(Float.parse(y), 0) end)
                end) 
    |> Enum.to_list
  end
end
