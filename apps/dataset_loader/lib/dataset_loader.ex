defmodule DatasetLoader do
  @moduledoc """
  Load Dateset.
  """
  
  def load(filepath), do: load(filepath, %{})
  
  def load(filepath, options) when is_list(options) do
    load(filepath, options |> Enum.into(%{}))
  end

  def load(filepath, %{headers: _} = options) do
    File.stream!(filepath)
    |> CSV.decode(Enum.into(options, []))
    |> Enum.to_list
    |> Enum.filter(fn x -> :ok == elem(x, 0) end)
    |> Enum.map(fn x -> elem(x, 1) end)
  end

  def load(filepath, options) do
    
    # load csv data
    File.stream!(filepath)
    |> CSV.decode(Enum.into(options, []))
    |> Enum.to_list
    |> Enum.filter(fn x -> :ok == elem(x, 0) end)
    |> Enum.map(fn x -> elem(x, 1) end)
    |> Enum.map(fn x -> x
                        |> Enum.map(fn y -> String.trim(y) end)
                end) 
    |> Enum.to_list
  end

end
