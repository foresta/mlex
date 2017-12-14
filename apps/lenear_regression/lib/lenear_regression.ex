defmodule LenearRegression do
  @moduledoc """
  Documentation for LenearRegression.
  """

  def computeCost(x, y, theta) do
    m = length(y)

    hx_y = x 
    |> Matrix.mult(theta)
    |> Matrix.sub(y)
    hx_y_2 = Matrix.emult(hx_y, hx_y)
    sum = hx_y_2
    |> Enum.reduce(0, fn(x, acc) -> Enum.at(x,0) + acc end)

    sum / (2*m)
  end

  def gradientDescent(x, y, theta, alpha, num_iters) do
    _gradientDescent(x, y, theta, alpha, num_iters, 0)
  end

  defp _gradientDescent(_x, _y, theta, _alpha, max_iter, iter) when iter > max_iter do
    theta
  end

  defp _gradientDescent(x, y, theta, alpha, max_iter, iter) do
    m = length(y)
  
    prevTheta = theta

    # X' * (X * theta - y)
    d = Matrix.mult(Matrix.transpose(x), Matrix.sub(Matrix.mult(x, theta), y))
    size = Matrix.size(d)

    # alpha * (1 / m)
    a = Matrix.new(elem(size,0), elem(size,1), alpha * (1 / m))

    # alpha * (1 / m) * X' * (X * theta - y)
    d = Matrix.emult(d, a)

    # theta = theta - alpha * (1/m) * X' * (X * theta - y)
    theta = Matrix.sub(theta, d)

    _gradientDescent(x, y, theta, alpha, max_iter, iter + 1)
  end

  def predict(x, theta) do
    Matrix.mult(x, theta)
  end

end
