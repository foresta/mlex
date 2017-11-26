defmodule Sample do
  @moduledoc """
  Documentation for Sample.
  """

  require Logger


  @doc """
  sample matrix 

  ## Examples
  iex> Sample.matrix
  [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]] 
  """
  def matrix do
     Matrix.new(3,4) 
  end

  @doc """
  plot with expyplot
  """
  def plot1 do
    
    a = [1,2,3,4,5]
    b = [100,300,200,500,600]
    plotter = Explotter.new
    Explotter.plot(plotter, a, b, :ro)
    Explotter.show(plotter)
  end

  @doc """
  plot example datas
  """
  def plot do
    plotter = Explotter.new
    Explotter.ylabel(plotter, "income")
    Explotter.xlabel(plotter, "years")
    Explotter.title(plotter, "rich!!")
    x = [2012, 2013, 2014, 2015, 2016]
    y = [1000, 1500, 2500, 4500, 8500]
    Explotter.plot(plotter, x, y, :ro, [label: "sample"])
    Explotter.show(plotter)
  end

  @doc """
  load csv data
  """
  def load_csv do
    DatasetLoader.load("apps/dataset_loader/test_data/data.csv")
  end

end
