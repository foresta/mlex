defmodule Coursera do

    def ex1 do

      data = DatasetLoader.load("apps/sample/dataset/coursera/ex1/ex1data1.txt")
      
      raw_x = data |> Enum.map(fn x -> Enum.at(x, 0) end) |> Enum.to_list
      raw_y = data |> Enum.map(fn y -> Enum.at(y, 1) end) |> Enum.to_list

      m = length(raw_x)
      
      # add bias parametter
      x = [ for _times <- 1..m do 1 end | [raw_x]]
      x = Matrix.transpose(x)

      theta = Matrix.zeros(2, 1)

      y = Matrix.transpose([raw_y])

      cost = LenearRegression.computeCost(x, y, theta)
      IO.puts "theta[0, 0], cost is #{cost}"

      theta = [[-1], [2]]
      cost = LenearRegression.computeCost(x,y,theta)
      IO.puts "theta[-1,2], cost is #{cost}"

      iterations = 1500
      alpha = 0.01
      theta = LenearRegression.gradientDescent(x, y, theta, alpha, iterations)

      cost = LenearRegression.computeCost(x,y,theta)

      IO.puts "================="
      IO.inspect theta
      IO.puts "cost is #{cost}"
      IO.puts "================="

      predict1 = Matrix.mult([[1, 3.5]], theta)
      IO.puts "For population = 3.5(35,000), we predict profit of"
      IO.inspect predict1

      # plot predict 
      theta0 = Enum.at(Enum.at(theta, 0), 0)
      theta1 = Enum.at(Enum.at(theta, 1), 0)  

      predict_y = raw_x |> List.flatten |> Enum.map(fn n -> theta0 + theta1 * n end) |> Enum.to_list  
      plotter = Explotter.new
      Explotter.plot(plotter, raw_x, raw_y, :rx, [label: "data"])
      Explotter.plot(plotter, raw_x, predict_y)
      Explotter.show(plotter)
    end
end
