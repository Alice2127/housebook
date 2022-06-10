defmodule Housebook.OutgosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Housebook.Outgos` context.
  """

  @doc """
  Generate a outgo.
  """
  def outgo_fixture(attrs \\ %{}) do
    {:ok, outgo} =
      attrs
      |> Enum.into(%{
        group_id: 42,
        payment: 42
      })
      |> Housebook.Outgos.create_outgo()

    outgo
  end
end
