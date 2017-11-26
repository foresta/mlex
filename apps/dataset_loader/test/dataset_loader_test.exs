defmodule DatasetLoaderTest do
  use ExUnit.Case
  doctest DatasetLoader

  test "load test_data/data.csv" do
    loaded_data = DatasetLoader.load("./test_data/data.csv")
    assert loaded_data == [[1,100], [2,150], [3,200], [4,250], [5,350]]
  end
end
