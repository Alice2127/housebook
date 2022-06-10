defmodule Debug do
  def print(data, msg) do
    IO.inspect("↓↓↓↓↓↓↓↓#{msg}↓↓↓↓↓↓↓↓")
    IO.inspect(data)
    IO.inspect("↑↑↑↑↑↑↑↑#{msg}↑↑↑↑↑↑↑↑")
    data
  end
end
