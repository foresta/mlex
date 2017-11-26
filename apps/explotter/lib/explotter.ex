defmodule Explotter do
  @moduledoc """
  Documentation for Explotter.
  """

  require Logger

  def new, do: Explot.new
  
  def xlabel(agent, label), do: Explot.xlabel(agent, label)

  def ylabel(agent, label), do: Explot.ylabel(agent, label)

  def title(agent, label), do: Explot.title(agent, label)

  def add_list(agent, list, list_name), do: Explot.add_list(agent, list, list_name)

  def x_axis_label(agent, array_of_labels), do: Explot.x_axis_labels(agent, array_of_labels)

  def y_axis_label(agent, array_of_labels) do
    {labels_available, array_of_indexes} = limit_indexes(array_of_labels)
    labels_to_print = to_python_array(labels_available)
    Explot.plot_command(agent, "yticks(#{to_python_array(array_of_indexes)}, #{labels_to_print})") #, rotation=60)")
  end

  def show(agent), do: Explot.show(agent)

  def plot(agent, xlist, ylist) do
    x = to_python_array(xlist)
    y = to_python_array(ylist)
    Explot.plot_command(agent, "plot(#{x}, #{y})")
  end

  def plot(agent, xlist, ylist, marker) when is_atom(marker) do
    plot(agent, xlist, ylist, Atom.to_string(marker))
  end

  def plot(agent, xlist, ylist, marker) do
    x = to_python_array(xlist)
    y = to_python_array(ylist)
    Explot.plot_command(agent, "plot(#{x}, #{y}, \"#{marker}\")")
  end

  def plot(agent, xlist, ylist, marker, _keywords = []) do
    plot(agent, xlist, ylist, marker)
  end

  def plot(agent, xlist, ylist, marker, keywords) when is_atom(marker) do
    plot(agent, xlist, ylist, Atom.to_string(marker), keywords)
  end

  def plot(agent, xlist, ylist, marker, keywords) do
    x = to_python_array(xlist)
    y = to_python_array(ylist)
    keyword = keyword_to_string(keywords)
    Explot.plot_command(agent, "plot(#{x}, #{y}, \"#{marker}\", #{keyword})")
  end

  defp keyword_to_string(keywords) do
    keywords
    |> Enum.map_join(",", fn {k,v} -> "#{k}=\"#{v}\"" end)
  end

  defp to_python_array([h | t]) when is_number(h) do
    comma_separated = [h | t] |> Enum.join(", ")
    "[#{comma_separated}]"
  end

  defp to_python_array([h | t]) when is_binary(h) do
    comma_separated = [h | t] |> Enum.map(fn(x) -> "'#{x}'" end) |> Enum.join(", ")
    "[#{comma_separated}]"
  end

  defp to_python_array([h | t]) when is_map(h) do
    comma_separated = [h | t] |> Enum.map(fn(x) -> "'#{Date.to_iso8601(x)}'" end) |> Enum.join(", ")
    "[#{comma_separated}]"
  end
  
  # Limits the amount of indexes shown in the graph so data is readable
  defp limit_indexes(array) do
    divisor = Enum.max([round(Float.floor(length(array) /10)), 1])
    data = Enum.take_every(array, divisor)
    indexes = Enum.take_every(Enum.to_list(0..length(array) -1), divisor)
    {data, indexes}
  end

end
