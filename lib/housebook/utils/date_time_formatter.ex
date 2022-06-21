defmodule Housebook.Utils.DateTimeFormatter do
  def format(time) do
    time
    |> Timex.to_datetime("Etc/UTC")
    |> Timex.to_datetime("Asia/Tokyo")
  end
end
