defmodule Coursera do

    def ex1 do

      data = DatasetLoader.load("apps/sample/dataset/coursera/ex1/ex1data1.txt")
      
      x = data |> Enum.map(fn x -> Enum.at(x, 0) end) |> Enum.to_list
      y = data |> Enum.map(fn y -> Enum.at(y, 1) end) |> Enum.to_list

      plotter = Explotter.new
      Explotter.plot(plotter, x, y, :rx, [label: "data1"])
      Explotter.show(plotter)

      m = length(x)
      
      # add bias parametter
      x = [ for times <- 1..m do 1 end | [x]]
      x = Matrix.transpose(x)

      theta = Matrix.zeros(2, 1)

      iterations = 1500
      
      # learning rate
      alpha = 0.01

      y = Matrix.transpose([y])

      cost = LenearRegression.computeCost(x, y, theta)
      IO.puts "theta[0, 0], cost is #{cost}"

      theta = [[-1], [2]]
      cost = LenearRegression.computeCost(x,y,theta)
      IO.puts "theta[-1,2], cost is #{cost}"
    end
end
