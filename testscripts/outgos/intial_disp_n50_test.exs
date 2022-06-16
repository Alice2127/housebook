alias Housebook.Outgos

for _x <- 1..50 do
  payment = 1..9
  |> Enum.random()

  %{group_id: 1, payment: payment * 10}
  |> Outgos.create_outgo()
end
