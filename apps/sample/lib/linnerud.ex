defmodule Linnerud do

  @doc """
  Lenear Regression with linnerud datasets
  
  features: physiological data 
    weight
    waist
    pulse
  
  targets: exersize data
    chins
    situps
    jumps


  """
  def run do
    # load dataset
    features = load_linnerud_feature_dataset()
    targets = load_linnerud_target_dataset()

    # setup features
    pulses = features[:pulse]
    waists = features[:waist]
    weights = features[:weight]
    number_of_data = length pulses
    bias = for _times <- 1..number_of_data, do: 1.0
  
    x = [bias, weights, waists, pulses]
    x = Matrix.transpose(x)

    # setup targets
    y = [ targets[:chins] ]
    y = Matrix.transpose(y) 

    # setup gradientDescent params
    alpha = 0.00003
    iterations = 10000
    theta = [[0], [0], [0], [0]]

    # train
    theta = LenearRegression.gradientDescent(x, y, theta, alpha, iterations)
  
    x_test = Matrix.transpose([[1],[191],[36],[50]])
    y_test = [[5]] 

    # predict
    predicted_chins = LenearRegression.predict(x_test, theta)

    # computeCost
    error = LenearRegression.computeCost(x_test, y_test, theta)

    IO.inspect y_test
    IO.inspect predicted_chins
    IO.inspect error
  end


  @doc """
  Polynomial Lenear Regression with linnerud datasets
  
  features: physiological data 
    weight
    waist
    pulse
  
  targets: exersize data
    chins
    situps
    jumps
  """
  def run_polynomial do
    features = load_linnerud_feature_dataset()
    targets  = load_linnerud_target_dataset()

    pulses = features[:pulse]
    waists = features[:waist]
    weights = features[:weight]
    number_of_data = length pulses
    bias = for _times <- 1..number_of_data, do: 1.0
    square_pulses = pulses |> Enum.map(fn x -> x * x end)
    square_waists = waists |> Enum.map(fn x -> x * x end)
    square_weights = weights |> Enum.map(fn x -> x * x end)
    pulses_waists  = pulses |> Enum.with_index |> Enum.map(fn {x,i} -> x * Enum.at(waists, i) end)
    pulses_weights = pulses |> Enum.with_index |> Enum.map(fn {x,i} -> x * Enum.at(weights, i) end)
    waists_weights = waists |> Enum.with_index |> Enum.map(fn {x,i} -> x * Enum.at(weights, i) end)

    x = [bias, weights, waists, pulses,
         square_weights, square_waists, square_pulses,
         pulses_waists, pulses_weights, waists_weights]
    x = Matrix.transpose(x)
   
    y = [ targets[:chins] ]
    y = Matrix.transpose(y)
  
    theta = [[0],[0],[0],[0],[0],[0],[0],[0],[0],[0]]
    alpha = 0.000000001
    iterations =10000

    theta = LenearRegression.gradientDescent(x, y, theta, alpha, iterations)

    test_weight = 191
    test_waists = 36
    test_pulse = 50
    x_test = [[1],[test_weight],[test_waists],[test_pulse],
              [test_weight*test_weight], [test_waists*test_waists], [test_pulse*test_pulse],
              [test_pulse*test_waists], [test_pulse*test_weight], [test_waists*test_weight]]
 
    predicted_chins = LenearRegression.predict(Matrix.transpose(x_test), theta)

    IO.inspect predicted_chins
  end

  @doc """
  plot dataset
  """
  def plot do
    features = load_linnerud_feature_dataset()
    targets = load_linnerud_target_dataset()

    plot_datasets(features, targets)
  end

  defp plot_datasets(features, target) do
    plotter = Explotter.new
    Explotter.plot(plotter, features[:weight], target[:chins], :ro, [label: "weight and chins"])
    Explotter.plot(plotter, features[:waist], target[:chins], :ro, [label: "waist and chins"])
    Explotter.plot(plotter, features[:pulse], target[:chins], :ro, [label: "pulse and chins"])
    Explotter.show(plotter)
 
  end

  defp load_linnerud_feature_dataset do
    "apps/sample/dataset/sample_data/linnerud_physiological.csv"
    |> load_linnerud_dataset
  end

  defp load_linnerud_target_dataset do
    "apps/sample/dataset/sample_data/linnerud_exercise.csv"
    |> load_linnerud_dataset
  end

  defp load_linnerud_dataset(filepath) do
    data = filepath
           |> DatasetLoader.load([headers: true])
   
    Map.keys(Enum.at(data, 0))
    |> Enum.map(fn key -> {
                            key 
                            |> String.downcase 
                            |> String.to_atom, 
                            data 
                            |> Enum.map(fn d -> d[key] end) 
                            |> Enum.map(fn d -> elem(Float.parse(d), 0) end)
                          } end)
  end


end
