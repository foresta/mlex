defmodule LenearRegression do
  @moduledoc """
  Documentation for LenearRegression.
  """

  @doc """
  Hello world.

  ## Examples

      iex> LenearRegression.hello
      :world

  """
  def hello do
    :world
  end

  def computeCost(x, y, theta) do
    m = length(y)

    hx = Matrix.mult(x, theta)
    hx_y = Matrix.sub(hx, y) 
    hx_y_2 = Matrix.emult(hx_y, hx_y)
    sum = hx_y_2
    |> Enum.reduce(0, fn(x, acc) -> Enum.at(x,0) + acc end)

    sum / (2*m)
  end



end
